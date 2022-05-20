###################################################################
# PACCHETTO "OMI" - Creazione databases e tabelle in MySQL server #
###################################################################

library(masteRfun)

dbn <- 'omi'
crea_db(dbn)

## TABELLA <ZONE> ---------------------
x <- "
    `OMI` CHAR(7) NOT NULL,
    `periodo` SMALLINT UNSIGNED NOT NULL,
    `catasto` CHAR(4) NOT NULL,
    `fascia` CHAR(1) NOT NULL,
    `zona` CHAR(3) NOT NULL,
    `OMId` VARCHAR(150) NOT NULL,
    `OMIk` VARCHAR(10) NOT NULL,
    `cod_prev` TINYINT NOT NULL,
    `` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (``, ``),
    UNIQUE KEY `nome_key` (``),
    KEY `nome_key` (``)
"
crea_tabella_db(dbn, 'nome_tabella', x)

## TABELLA <PREVALENTI> ---------------
x <- "
    `` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `` CHAR(12) NOT NULL,
    `` CHAR(7) NULL DEFAULT NULL,
    `` VARCHAR(50) NOT NULL,
    `` DECIMAL(10,8) NOT NULL,
    `` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (``, ``),
    UNIQUE KEY `nome_key` (``),
    KEY `nome_key` (``)
"
crea_tabella_db(dbn, 'prevalenti', x)

## TABELLA <TIPI_QUOTE> ---------------
x <- "
    `` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `` CHAR(12) NOT NULL,
    `` CHAR(7) NULL DEFAULT NULL,
    `` VARCHAR(50) NOT NULL,
    `` DECIMAL(10,8) NOT NULL,
    `` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (``, ``),
    UNIQUE KEY `nome_key` (``),
    KEY `nome_key` (``)
"
crea_tabella_db(dbn, 'tipi_quote', x)

## TABELLA <TIPI_TRANS> ---------------
x <- "
    `` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `` CHAR(12) NOT NULL,
    `` CHAR(7) NULL DEFAULT NULL,
    `` VARCHAR(50) NOT NULL,
    `` DECIMAL(10,8) NOT NULL,
    `` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (``, ``),
    UNIQUE KEY `nome_key` (``),
    KEY `nome_key` (``)
"
crea_tabella_db(dbn, 'tipi_trans', x)



## TABELLA <QUOTAZIONI> ---------------
x <- "
    `` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `` CHAR(12) NOT NULL,
    `` CHAR(7) NULL DEFAULT NULL,
    `` VARCHAR(50) NOT NULL,
    `` DECIMAL(10,8) NOT NULL,
    `` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (``, ``),
    UNIQUE KEY `nome_key` (``),
    KEY `nome_key` (``)
"
crea_tabella_db(dbn, 'quotazioni', x)

## TABELLA <TRANSAZIONI> --------------
x <- "
    `` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `` CHAR(12) NOT NULL,
    `` CHAR(7) NULL DEFAULT NULL,
    `` VARCHAR(50) NOT NULL,
    `` DECIMAL(10,8) NOT NULL,
    `` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (``, ``),
    UNIQUE KEY `nome_key` (``),
    KEY `nome_key` (``)
"
crea_tabella_db(dbn, 'transazioni', x)

## FINE -------------------------------
rm(list = ls())
gc()
