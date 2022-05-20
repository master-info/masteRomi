#########################################
# PACCHETTO "OMI" - Elaborazione Codici #
#########################################
# https://www.agenziaentrate.gov.it/portale/web/guest/schede/fabbricatiterreni/omi/forniture-dati-omi

masteRfun::load_pkgs(master = FALSE, 'data.table')

omi_path <- file.path(ext_path, 'OMI', 'QI')

# CODICI COMUNI
y <- data.table()
for(anno in 2016:2021){
    for(s in 1:2){
        message('Elaboro anno ', anno, ', semestre ', s)
        yt <- unique(fread(
                file.path(omi_path, paste0('QI_', anno, s, '_ZONE.csv')),
                select = c('Comune_ISTAT', 'Comune_descrizione', 'Comune_cat', 'Comune_amm'),
                col.names = c('CMN', 'CMNd', 'nazionale', 'catasto')
                
        ))
        yt <- yt[!is.na(CMN) & CMN > 0]
        y <- unique(rbindlist(list( y, yt )))
    }
}
y[CMN > 1000000, CMN2 := as.numeric(substring(CMN, nchar(CMN) -5))]
fwrite(y, './data-raw/csv/cmn_omi-nuovo.csv')

# USO PREVALENTE
y <- data.table()
for(anno in 2016:2021){
    for(s in 1:2){
        message('Elaboro anno ', anno, ', semestre ', s)
        yt <- unique(fread(
            file.path(omi_path, paste0('QI_', anno, s, '_ZONE.csv')),
            select = c('Cod_tip_prev', 'Descr_tip_prev'),
            col.names = c('codice', 'descrizione')
        ))
        y <- unique(rbindlist(list( y, yt )))
    }
}
fwrite(y[, c('gruppo', 'ordine') := NA_character_][order(codice)], './data-raw/csv/omi_prevalenti-nuovo.csv')

# TIPOLOGIA EDIFICIO
y <- data.table()
for(anno in 2016:2021){
    for(s in 1:2){
        message('Elaboro anno ', anno, ', semestre ', s)
        yt <- unique(fread(
            file.path(omi_path, paste0('QI_', anno, s, '_VALORI.csv')),
            select = c('Cod_Tip', 'Descr_Tipologia'),
            col.names = c('codice', 'descrizione')
        ))
        y <- unique(rbindlist(list( y, yt )))
    }
}
fwrite(y[, c('gruppo', 'ordine') := NA_character_][order(codice)], './data-raw/csv/omi_tipo_quote-nuovo.csv')

rm(list = ls())
gc()
