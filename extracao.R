###



# install.packages("PNADcIBGE")
# install.packages("survey")

# pacotes
library(survey)
library(PNADcIBGE)
library(data.table)
library(glue)


anos <- c(2012:2017)
trimestres <- c(1:4)

# carregando lista de ufs
ufs_list <-read.table("R\\pnadc\\ufs.txt", fileEncoding ='utf-8', sep = '\t', skip = 1)
ufs <- unlist(ufs_list)


# carregando algumas variáveis
variaveis_selecionadas <- c("V1029", "UF", "V2007", "V2010", "VD3004", "VD4001", 
                            "VD4002", "VD4003", "VD4004", "VD4004A", "VD4005", "VD4009", "VD4010")


for (ano in anos) {
  for (tri in trimestres) {
    if (ano == 2020 & tri > 2) { break; }
    print(glue("o ano é {ano}, o tri é {tri}"))
    
    dadosPNADc <- get_pnadc(year = ano, quarter = tri, vars = variaveis_selecionadas)
    
    # print('populacao estados')
    # for (uf in ufs) {
    #   pop_uf <- svytotal(~ V1029 + interaction(V2007, V2010), subset(dadosPNADc, UF == uf), na.rm = T)
    #   dt <- data.table(var=attributes(pop_uf)$names, pop_uf)
    #   fwrite(dt, file=glue("R\\pnadc\\populacao\\pop_sexo_cor_{ano}{tri}_{uf}.csv"))
    # }
    
    # print('força de trabalho')
    # for (uf in ufs) {
    #   forca_trb <- svytotal(~ interaction(VD4001, V2007, V2010), subset(dadosPNADc, UF == uf), na.rm = T)
    #   dtft <- data.table(var=attributes(forca_trb)$names, forca_trb)
    #   fwrite(dtft, file=glue("R\\pnadc\\forca_trabalho\\forca_trab_sexo_cor_{ano}{tri}_{uf}.csv"))
    # }
    # 
    # 
    # print('força trab potencial')
    # for (uf in ufs) {
    #   poten <- svytotal(~ interaction(VD4003, V2007, V2010), subset(dadosPNADc, UF == uf), na.rm = T)
    #   dtpotenc <- data.table(var=attributes(poten)$names, poten)
    #   fwrite(dtpotenc, file=glue("R\\pnadc\\forca_trab_potencial\\forcatrab_potencial_sexo_cor_{ano}{tri}_{uf}.csv"))
    # }
    
    
    # print('ocupados')
    # for (uf in ufs) {
    #   ocup <- svytotal(~ interaction(VD4002, V2007, V2010), subset(dadosPNADc, UF == uf), na.rm = T)
    #   dtocp <- data.table(var=attributes(ocup)$names, ocup)
    #   fwrite(dtocp, file=glue("R\\pnadc\\ocupados\\situacao_ocup_sexo_cor_{ano}{tri}_{uf}.csv"))
    # }
    
    
    # print('subocupados')
    # ano_tri <- glue("{ano}{tri}")
    # if(ano_tri >= 20153) {
    #   sub_var <- dadosPNADc$variables$VD4004A
    # } else {
    #     sub_var <- dadosPNADc$variables$VD4004
    #   } 
    # 
    # 
    # for (uf in ufs) {
    #   subocup <- svytotal(~ interaction(sub_var, V2007, V2010), subset(dadosPNADc, UF == uf), na.rm = T)  
    #   dtsocp <- data.table(var=attributes(subocup)$names, subocup)
    #   fwrite(dtsocp, file=glue("R\\pnadc\\subocupados\\subocup_sexo_cor_{ano}{tri}_{uf}.csv"))
    # }
    
    
    # print('desalentados')
    # for (uf in ufs) {
    #   desalent <- svytotal(~ interaction(VD4005, V2007, V2010), subset(dadosPNADc, UF == uf), na.rm = T)
    #   dtdes <- data.table(var=attributes(desalent)$names, desalent)
    #   fwrite(dtdes, file=glue("R\\pnadc\\desalentados\\desalent_sexo_cor_{ano}{tri}_{uf}.csv"))
    # }
    
    
    # print('posicao')
    # for (uf in ufs) {
    #   posicao <- svytotal(~ interaction(VD4009, V2007, V2010), subset(dadosPNADc, UF == uf), na.rm = T)
    #   dtpos <- data.table(var=attributes(posicao)$names, posicao)
    #   fwrite(dtpos, file=glue("R\\pnadc\\posicao\\posicao_sexo_cor_{ano}{tri}_{uf}.csv"))
    # }
    # 
    # 
    print('atividade')
    for (uf in ufs) {
      ativ <- svytotal(~ interaction(VD4010, V2007, V2010), subset(dadosPNADc, UF == uf), na.rm = T)
      dtativ <- data.table(var=attributes(ativ)$names, ativ)
      fwrite(dtativ, file=glue("R\\pnadc\\atividade\\atividade_sexo_cor_{ano}{tri}_{uf}.csv"))
    }
    # 
    # 
    # print('curso mais elevado')
    # for (uf in ufs) {
    #   curso <- svytotal(~ interaction(VD3004, V2007, V2010), subset(dadosPNADc, UF == uf), na.rm = T)
    #   dtcurso <- data.table(var=attributes(curso)$names, curso)
    #   fwrite(dtcurso, file=glue("R\\pnadc\\curso\\curso_sexo_cor_{ano}{tri}_{uf}.csv"))
    # }
    
  }
}