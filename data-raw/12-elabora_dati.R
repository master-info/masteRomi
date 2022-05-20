#######################################
# PACCHETTO "OMI" - Elaborazione Dati #
#######################################
# https://www.agenziaentrate.gov.it/portale/web/guest/schede/fabbricatiterreni/omi/forniture-dati-omi

masteRfun::load_pkgs(master = FALSE, 'data.table')

omi_path <- file.path(ext_path, 'OMI', 'QI')

# ZONE
y <- data.table()
for(anno in 2016:2021){
    for(s in 1:2){
        message('Elaboro anno ', anno, ', semestre ', s)
        yt <- fread(
            file.path(omi_path, paste0('QI_', anno, s, '_ZONE.csv')),
            select = c('Comune_amm', 'Fascia', 'Zona', 'Zona_Descr', 'LinkZona', 'Cod_tip_prev', 'Stato_prev', 'Microzona'),
            col.names = c('catasto', 'fascia', 'zona', 'OMId', 'OMIk', 'cod_prev', 'stato_prev', 'microzona')
        )
        yt[, OMI := paste0(catasto, zona)]
        y <- rbindlist(list( y, data.table( periodo = anno * 10 + s, yt ) ))
    }
}
y <- y[y[, .I[which.max(periodo)], OMI]$V1][order(-periodo, OMI)][order(OMI)]
y[, OMId := trimws(gsub("^'|'$|^-{0,2}", '', y$OMId))]
y[y == ''] <- NA
setcolorder(y, c('OMI', 'periodo', 'catasto', 'fascia', 'zona'))
fwrite(y, './data-raw/csv/omi_zone.csv')

# QUOTAZIONI
y <- data.table()
for(anno in 2016:2021){
    for(s in 1:2){
        message('Elaboro anno ', anno, ', semestre ', s)
        yt <- fread(
                file.path(omi_path, paste0('QI_', anno, s, '_VALORI.csv')),
                select = c('Comune_amm', 'Zona', 'Stato', 'Cod_Tip', 'Compr_min', 'Compr_max', 'Loc_min', 'Loc_max'),
                col.names = c('catasto', 'zona', 'stato', 'cod_tipo', 'min_acq', 'max_acq', 'min_loc', 'max_loc')
        )
        yt[, OMI := paste0(catasto, zona)][, c('catasto', 'zona') := NULL]
        yt[, stato := substr(stato, 1, 1)]
        y <- rbindlist(list( y, data.table( periodo = anno * 10 + s, yt ) ))
    }
}
y[y == '' | y == 0] <- NA
y[, `:=`( min_loc = as.numeric(gsub(',', '.', min_loc)), max_loc = as.numeric(gsub(',', '.', max_loc))), ]
y <- melt(y, 
        id.vars = c('OMI', 'periodo', 'cod_tipo', 'stato'), 
        variable.name = 'variabile', variable.factor = FALSE,
        value.name = 'valore', na.rm = TRUE
)
setorderv(y)
fwrite(y, './data-raw/csv/omi_quote.csv')
zip('./data-raw/csv/omi_quote.zip', './data-raw/csv/omi_quote.csv')
file.remove('./data-raw/csv/omi_quote.csv')

# TRANSAZIONI
omi_path <- file.path(ext_path, 'OMI', 'VC')
y <- data.table()
for(anno in 2011:2020){
    message('Elaboro anno: ', anno)
    for(tp in c('RES', 'PER', 'COM')){
        message(' > tipologia: ', tp, '...')
        strx <- paste0('NTN_', anno)
        yt <- fread(file.path(omi_path, paste0('VC_', anno, '_VALORI-', tp, '.csv')), drop = 1:3)
        setnames(yt, 1, 'catasto')
        yt <- yt[!grepl(anno, catasto)]
        names(yt) <- gsub(paste0(strx, '_|_mq'), '', gsub(' {1,3}', '_', names(yt)))
        if(length(grep(strx, names(yt))) > 0) setnames(yt, strx, 'TOT_RES')
        yt <- melt(yt, id.vars = 1, variable.factor = FALSE)
        yt[, value := as.numeric(gsub(',', '.', value))]
        y <- rbindlist(list( y, data.table( periodo = anno, yt ) ))
    }
}
y[y == '' | y == 0] <- NA
y[, variable := gsub('NTN_', '', variable)]
y[, variable := gsub('_-|_', '-', variable, fixed = TRUE)]
y[variable == 'TOTALE', variable := 'TOT_RES']
setorderv(y)
fwrite(y, './data-raw/csv/omi_trans.csv')
zip('./data-raw/csv/omi_trans.zip', './data-raw/csv/omi_trans.csv')
file.remove('./data-raw/csv/omi_trans.csv')

rm(list = ls())
gc()
