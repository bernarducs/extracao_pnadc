###



# install.packages("PNADcIBGE")
# install.packages("survey")

# pacotes
library(survey)
library(PNADcIBGE)
library(data.table)
library(glue)


anos <- c(2016)
trimestres <- c(3:4)

# carregando lista de ufs
ufs_list <-read.table("R\\pnadc\\ufs.txt", fileEncoding ='utf-8', sep = '\t', skip = 1)
ufs <- unlist(ufs_list)


# carregando algumas variáveis
# variaveis_selecionadas <- c("V1029", "UF", "V2007", "V2010", "VD4009", "VD4010", "VD4020")
variaveis_selecionadas <- c("UF", "VD4020", "VD4010")


for (ano in anos) {
  for (tri in trimestres) {
    if (ano == 2020 & tri > 2) { break; }
    print(glue("o ano é {ano}, o tri é {tri}"))
    
    dadosPNADc <- get_pnadc(year = ano, quarter = tri, vars = variaveis_selecionadas)
    
    # rnd_media_uf <- svyby(~VD4020, ~UF, dadosPNADc, svytotal(), na.rm = T)
    # fwrite(data.table(rnd_media_uf), file=glue("R\\pnadc\\rendimentos\\rendimentos_uf\\renda_media_{ano}{tri}.csv"))
    
    print('populacao estados')
    for (uf in ufs) {
      print(uf)
      dt <- data.table(svyby(~VD4020, ~VD4010, subset(dadosPNADc, UF == uf), svymean, na.rm = T))
      fwrite(dt, file=glue("R\\pnadc\\rendimentos\\atividade\\renda_media_{ano}{tri}_{uf}.csv"))
    }
    
  }
}