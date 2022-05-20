################################################
# Copia dati da PUBLIC REPO a PACKAGE DATA DIR #
################################################

library(data.table)

fn <- 'nome_tabella'
y <- fread('./data-raw/csv/nomefile.csv')
assign(fn, y)
save( list = fn, file = file.path('data', paste0(fn, '.rda')), version = 3, compress = 'gzip' )
masteRfun::dbm_do('nome_db', 'w', fn, y)
