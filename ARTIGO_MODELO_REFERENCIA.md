# Referencia Tecnica do Modelo de Artigo

## Arquivo analisado

- `C:/Users/use/Downloads/1.APR.5595.docx`

## Objetivo desta referencia

Registrar os achados do artigo-modelo que devem orientar a evolucao do preset `Artigo`.

Este arquivo existe para nao perder:

- a estrutura real do documento
- os elementos de cabecalho e rodape
- os campos variaveis sugeridos
- os pontos que o formatador precisa preservar ou ajustar

---

## Resumo executivo

O artigo-modelo nao e apenas um texto com formatacao.

Ele traz:

- primeira pagina especial
- cabecalhos diferentes entre primeira pagina e demais paginas
- rodapes diferentes entre primeira pagina e demais paginas
- imagens no cabecalho e no rodape
- numeracao de pagina com campo do Word
- metadados editoriais no cabecalho
- texto de citacao e licenca no rodape

Conclusao:

- o preset `Artigo` nao deve ser tratado apenas como um conjunto de fonte, margem e espacamento
- ele deve evoluir para um preset baseado em `template base`

---

## Estrutura identificada no .docx

Arquivos relevantes encontrados dentro do Word:

- `word/document.xml`
- `word/styles.xml`
- `word/footnotes.xml`
- `word/endnotes.xml`
- `word/header1.xml`
- `word/header2.xml`
- `word/footer1.xml`
- `word/footer2.xml`
- `word/numbering.xml`
- `word/_rels/document.xml.rels`

Observacoes:

- existe `titlePg`, ou seja, primeira pagina diferenciada
- a secao principal usa:
  - `header1.xml` como cabecalho padrao
  - `header2.xml` como cabecalho da primeira pagina
  - `footer1.xml` como rodape padrao
  - `footer2.xml` como rodape da primeira pagina

---

## Configuracao de pagina identificada

No modelo analisado:

- formato A4
- margens:
  - superior: `2 cm`
  - inferior: `2 cm`
  - esquerda: `2 cm`
  - direita: `2 cm`
- distancia do cabecalho: `1,25 cm`
- distancia do rodape: `1,25 cm`
- numeracao iniciando em `1`

---

## Regras de paragrafo observadas

No corpo do artigo, os paragrafos analisados aparecem com:

- `Antes = 0 pt`
- `Depois = 0 pt`
- `Entre linhas = simples`

Isso confirma a necessidade de o formatador forcar:

- `before = 0`
- `after = 0`

no processamento do preset `Artigo` e, por seguranca, nos paragrafos processados em geral.

---

## Estrutura do inicio do artigo

Trechos detectados na abertura do documento:

1. titulo em portugues em caixa alta
2. nome do autor
3. instituicao
4. ORCID
5. e-mail
6. bloco `RESUMO:`
7. texto do resumo
8. bloco `PALAVRAS-CHAVE:`
9. titulo em ingles
10. bloco `ABSTRACT:`
11. texto do abstract
12. bloco `KEYWORDS:`
13. inicio do corpo do artigo

Isso e uma boa base para:

- `extractionRules`
- `structureHints`
- `fields` do preset `Artigo`

---

## Cabecalho padrao

### Cabecalho das paginas internas

O cabecalho padrao contem:

- nome da revista
- cidade/UF
- volume
- numero
- intervalo de paginas
- mes
- ano
- ISSN

Texto observado no modelo:

- `Griot: Revista de Filosofia, Amargosa - BA, v.26, n.1, p.1-19, fevereiro, 2026`
- `ISSN 2178-1036`

### Cabecalho da primeira pagina

O cabecalho da primeira pagina contem:

- logo da revista
- linha da revista com volume, numero e paginas
- ISSN
- logo/elemento do DOI
- link DOI
- datas editoriais em portugues
- datas editoriais em ingles

Campos editoriais observados:

- `Recebido`
- `Aprovado`
- `Received`
- `Approved`

Conclusao:

- o preset `Artigo` precisa prever primeira pagina especial
- o cabecalho nao deve ser reconstruido "na unha" apenas com texto solto
- o melhor caminho e usar um `template base`

---

## Rodape padrao

### Rodape das paginas internas

O rodape padrao contem:

- numero da pagina em campo do Word `PAGE`
- linha de citacao curta do artigo

Observacao importante:

- o numero da pagina e dinamico
- o restante da linha esta em texto fixo

### Rodape da primeira pagina

O rodape da primeira pagina contem:

- citacao do artigo
- referencia curta com volume, numero, paginas e data
- texto de licenca
- imagem/licenca visual

Conclusao:

- o preset `Artigo` precisara preservar ou preencher esse rodape
- ha partes dinamicas e partes que hoje estao fixas no modelo

---

## Campos variaveis sugeridos para o preset Artigo

Campos estruturais principais:

- `titulo_pt`
- `titulo_en`
- `autor_nome`
- `autor_instituicao`
- `autor_orcid`
- `autor_email`
- `resumo`
- `palavras_chave`
- `abstract`
- `keywords`

Campos editoriais do cabecalho:

- `doi`
- `recebido_em`
- `aprovado_em`
- `received_em`
- `approved_em`

Campos bibliograficos do cabecalho e rodape:

- `revista_nome`
- `cidade_uf`
- `volume`
- `numero`
- `pagina_inicial`
- `pagina_final`
- `mes_publicacao`
- `ano_publicacao`
- `issn`

Campos da linha de citacao:

- `citacao_rodape`
- `licenca_texto`

Observacao:

- `pagina_atual` nao deve ser texto fixo
- isso ja existe como campo do Word no rodape

---

## Campos que podem ser extraidos automaticamente

Sugestoes iniciais de extracao:

- `titulo_pt`
  - primeiro paragrafo relevante do documento

- `autor_nome`
  - linha logo abaixo do titulo principal

- `autor_instituicao`
  - linha abaixo do autor

- `autor_orcid`
  - linha com URL do ORCID

- `autor_email`
  - linha com `E-mail:`

- `resumo`
  - paragrafo logo apos `RESUMO:`

- `palavras_chave`
  - linha com `PALAVRAS-CHAVE:`

- `titulo_en`
  - titulo em ingles antes de `ABSTRACT:`

- `abstract`
  - paragrafo logo apos `ABSTRACT:`

- `keywords`
  - linha com `KEYWORDS:`

Campos que provavelmente virao melhor por template ou preenchimento manual:

- `doi`
- `recebido_em`
- `aprovado_em`
- `received_em`
- `approved_em`
- `citacao_rodape`
- `licenca_texto`

---

## Recomendacao tecnica para o preset Artigo

### Curto prazo

Usar o modelo como referencia para:

- zerar `Antes` e `Depois`
- manter margens de `2 cm`
- manter espacamento simples
- mapear os campos principais do corpo do artigo

### Medio prazo

Transformar o `Artigo` em preset orientado por template, com suporte a:

- primeira pagina especial
- cabecalho padrao
- rodape padrao
- metadados editoriais
- pagina atual dinamica

### Regra de implementacao

Para o `Artigo`, o sistema deve separar:

1. `formatacao do corpo`
- fonte
- espacamento
- margens
- recuos

2. `estrutura editorial`
- cabecalho
- rodape
- DOI
- datas editoriais
- citacao curta
- licenca

O item 2 deve ser tratado como camada de template institucional.

---

## Decisoes registradas

- o preset `Artigo` vai precisar de suporte a `header*.xml` e `footer*.xml`
- a primeira pagina deve ser tratada como especial
- o modelo de artigo analisado deve servir como referencia real do preset
- os campos variaveis listados acima devem entrar no desenho do preset
- o problema de `Antes/Depois` precisa permanecer zerado
- pagina atual deve continuar dinamica via campo do Word, nao como texto fixo

