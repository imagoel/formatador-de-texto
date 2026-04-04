# Especificacao do Preset Artigo

## Objetivo

Detalhar a primeira implementacao de preset com campos dinamicos usando o modelo de artigo ja analisado.

Esta especificacao transforma o roadmap geral em uma base pratica de implementacao para o preset `Artigo`.

O preset `Artigo` deve:

- continuar aceitando upload de `.docx`
- aplicar o padrao visual institucional
- tentar extrair campos relevantes do artigo
- permitir correcao manual dos campos
- permitir mapeamento manual assistido na previa
- manter a triagem do artigo
- preparar o caminho para evolucao futura com template de cabecalho e rodape

---

## Principio de funcionamento

O `Artigo` nao sera um gerador de documento do zero no primeiro ciclo.

Ele sera um preset inteligente sobre um arquivo enviado.

Fluxo esperado:

1. usuario seleciona `Artigo`
2. usuario envia o `.docx`
3. sistema aplica os parametros visuais do preset
4. sistema tenta extrair campos do artigo
5. campos aparecem preenchidos, vazios ou sugeridos
6. usuario revisa os campos
7. se necessario, usuario aponta o trecho correto na previa
8. sistema aplica os ajustes pontuais no documento
9. sistema roda a triagem
10. sistema baixa o `.docx` final

---

## Escopo do primeiro ciclo

### Incluido agora

- formatacao visual do corpo
- campos do inicio do artigo
- triagem do artigo
- extracao automatica simples
- mapeamento manual assistido por paragrafo
- zerar `Antes` e `Depois`

### Preparado, mas nao implementado ainda

- alteracao automatica de `header*.xml`
- alteracao automatica de `footer*.xml`
- substituicao completa de DOI, datas editoriais e citacao curta no cabecalho/rodape
- template editorial completo da revista

### Fora do primeiro ciclo

- geracao de PDF
- backend
- numeracao institucional oficial
- selecao de texto fina dentro de paragrafo

---

## Preset Artigo - schema proposto

```js
{
  id: 'artigo',
  name: 'Artigo',
  builtIn: true,
  articleReview: true,
  values: {
    fonte: 'Bodoni MT',
    sizeNormal: 12,
    sizeCompact: 10,
    spacingNormal: '1',
    spacingCompact: '1',
    indentFirst: 1.25,
    mTop: 2,
    mBottom: 2,
    mLeft: 2,
    mRight: 2,
    chkAlign: false
  },
  fieldsEnabled: true,
  structureHints: [...],
  fields: [...],
  extractionRules: [...],
  mappingRules: [...],
  validations: [...],
  manualMapping: {
    enabled: true,
    mode: 'paragraph'
  },
  articleTemplate: {
    bodyOnlyInV1: true,
    futureTemplateSupport: true
  }
}
```

---

## Blocos de campos

Os campos do preset `Artigo` devem ser organizados em tres blocos.

### 1. Bloco do artigo

Campos ligados ao inicio e ao corpo do texto:

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

### 2. Bloco editorial

Campos que existem no modelo, mas devem entrar como camada futura ou semiautomatica:

- `doi`
- `recebido_em`
- `aprovado_em`
- `received_em`
- `approved_em`

### 3. Bloco bibliografico

Campos do cabecalho e rodape da revista:

- `revista_nome`
- `cidade_uf`
- `volume`
- `numero`
- `pagina_inicial`
- `pagina_final`
- `mes_publicacao`
- `ano_publicacao`
- `issn`
- `citacao_rodape`
- `licenca_texto`

---

## Campos do primeiro ciclo

No primeiro ciclo de implementacao, eu recomendo ativar na interface apenas estes campos:

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

Esses campos ja trazem valor real e se apoiam em estruturas que aparecem no corpo do documento.

Os campos editoriais e bibliograficos devem ficar registrados no schema, mas podem ficar:

- ocultos na interface por enquanto
- marcados como `future`
- usados apenas no planejamento do template editorial

---

## Definicao dos campos do primeiro ciclo

```js
fields: [
  {
    id: 'titulo_pt',
    label: 'Titulo em portugues',
    group: 'artigo',
    type: 'text',
    required: true,
    applyMode: 'replace',
    allowManualMap: true
  },
  {
    id: 'titulo_en',
    label: 'Titulo em ingles',
    group: 'artigo',
    type: 'text',
    required: true,
    applyMode: 'replace',
    allowManualMap: true
  },
  {
    id: 'autor_nome',
    label: 'Nome do autor',
    group: 'artigo',
    type: 'text',
    required: true,
    applyMode: 'replace',
    allowManualMap: true
  },
  {
    id: 'autor_instituicao',
    label: 'Instituicao',
    group: 'artigo',
    type: 'text',
    required: true,
    applyMode: 'replace',
    allowManualMap: true
  },
  {
    id: 'autor_orcid',
    label: 'ORCID',
    group: 'artigo',
    type: 'text',
    required: false,
    applyMode: 'replace',
    allowManualMap: true
  },
  {
    id: 'autor_email',
    label: 'E-mail',
    group: 'artigo',
    type: 'text',
    required: false,
    applyMode: 'replace',
    allowManualMap: true
  },
  {
    id: 'resumo',
    label: 'Resumo',
    group: 'artigo',
    type: 'textarea',
    required: true,
    applyMode: 'replace',
    allowManualMap: true
  },
  {
    id: 'palavras_chave',
    label: 'Palavras-chave',
    group: 'artigo',
    type: 'tags',
    required: true,
    applyMode: 'replace',
    allowManualMap: true
  },
  {
    id: 'abstract',
    label: 'Abstract',
    group: 'artigo',
    type: 'textarea',
    required: true,
    applyMode: 'replace',
    allowManualMap: true
  },
  {
    id: 'keywords',
    label: 'Keywords',
    group: 'artigo',
    type: 'tags',
    required: true,
    applyMode: 'replace',
    allowManualMap: true
  }
]
```

---

## Estados visuais dos campos

Cada campo do preset `Artigo` deve mostrar seu estado de origem.

Estados minimos:

- `Detectado automaticamente`
- `Selecionado no documento`
- `Preenchido manualmente`
- `Nao encontrado`
- `Texto padrao do modelo`

Representacao sugerida:

- badge pequena ao lado do label
- cor consistente
- tooltip ou texto curto explicando a origem

Exemplo de leitura pelo usuario:

- `Resumo` — `Detectado automaticamente`
- `Keywords` — `Nao encontrado`
- `Autor` — `Selecionado no documento`

---

## Structure hints do Artigo

Os `structureHints` vao medir o quanto o arquivo parece um artigo compativel com esse preset.

Sugestao inicial:

```js
structureHints: [
  { type: 'has_uppercase_title_near_start', weight: 2 },
  { type: 'has_section_label', value: 'RESUMO', weight: 3 },
  { type: 'has_section_label', value: 'ABSTRACT', weight: 3 },
  { type: 'has_section_label', value: 'PALAVRAS-CHAVE', weight: 2 },
  { type: 'has_section_label', value: 'KEYWORDS', weight: 2 },
  { type: 'has_email_line', weight: 1 },
  { type: 'has_orcid_url', weight: 1 }
]
```

Leitura de confianca:

- pontuacao alta = `Estrutura reconhecida`
- pontuacao media = `Estrutura parcialmente reconhecida`
- pontuacao baixa = `Estrutura nao reconhecida`

---

## Extraction rules do Artigo

As primeiras `extractionRules` devem ser simples e previsiveis.

```js
extractionRules: [
  { field: 'titulo_pt', type: 'first_non_empty_paragraph' },
  { field: 'autor_nome', type: 'paragraph_after_field', afterField: 'titulo_pt' },
  { field: 'autor_instituicao', type: 'paragraph_after_field', afterField: 'autor_nome' },
  { field: 'autor_orcid', type: 'first_paragraph_matching', pattern: 'orcid.org' },
  { field: 'autor_email', type: 'first_paragraph_matching', pattern: 'E-mail:' },
  { field: 'resumo', type: 'paragraph_after_label', labels: ['RESUMO', 'RESUMO:'] },
  { field: 'palavras_chave', type: 'paragraph_matching', labels: ['PALAVRAS-CHAVE', 'PALAVRAS-CHAVE:'] },
  { field: 'titulo_en', type: 'paragraph_before_label', labels: ['ABSTRACT', 'ABSTRACT:'] },
  { field: 'abstract', type: 'paragraph_after_label', labels: ['ABSTRACT', 'ABSTRACT:'] },
  { field: 'keywords', type: 'paragraph_matching', labels: ['KEYWORDS', 'KEYWORDS:'] }
]
```

Regra de UX:

- extraido com seguranca alta: campo preenchido
- extraido com seguranca media: campo preenchido + aviso visual
- falha de extracao: campo vazio + `Selecionar no documento`

---

## Mapping rules do Artigo

No primeiro ciclo, o mapeamento deve se concentrar apenas no corpo do documento.

```js
mappingRules: [
  { field: 'titulo_pt', targetType: 'sourceRef', fallback: 'first_non_empty_paragraph' },
  { field: 'autor_nome', targetType: 'sourceRef' },
  { field: 'autor_instituicao', targetType: 'sourceRef' },
  { field: 'autor_orcid', targetType: 'sourceRef' },
  { field: 'autor_email', targetType: 'sourceRef' },
  { field: 'resumo', targetType: 'sourceRef' },
  { field: 'palavras_chave', targetType: 'sourceRef' },
  { field: 'titulo_en', targetType: 'sourceRef' },
  { field: 'abstract', targetType: 'sourceRef' },
  { field: 'keywords', targetType: 'sourceRef' }
]
```

Regra:

- se o campo tem `sourceRef`, substituir no trecho mapeado
- se nao tem `sourceRef`, usar fallback baseado na estrutura
- se ainda assim nao houver destino seguro, nao substituir silenciosamente

---

## Mapeamento manual assistido

Primeira entrega recomendada:

- selecao por paragrafo inteiro

Fluxo:

1. usuario clica em `Selecionar no documento`
2. a previa entra em modo de selecao
3. os paragrafos ficam clicaveis
4. usuario escolhe o paragrafo correto
5. o campo recebe:
   - valor
   - `sourceState = selected_in_document`
   - `sourceRef`

Esse `sourceRef` precisa apontar para a origem real do paragrafo no documento.

Estrutura minima:

```js
sourceRef: {
  file: 'word/document.xml',
  paragraphIndex: 13
}
```

---

## Validacoes do Artigo

O preset `Artigo` deve ter dois niveis de validacao.

### 1. Validacoes estruturais

- titulo em portugues presente
- titulo em ingles presente
- resumo presente
- abstract presente
- palavras-chave presentes
- keywords presentes

### 2. Validacoes editoriais

- resumo entre 150 e 250 palavras
- abstract entre 150 e 250 palavras
- palavras-chave entre 3 e 6
- keywords entre 3 e 6
- paginas entre 12 e 30

### 3. Validacoes de compatibilidade com o modelo

- arquivo parece artigo
- arquivo contem marcadores minimos
- estrutura reconhecida ou parcialmente reconhecida

---

## Interface do preset Artigo

### Coluna da direita

Blocos:

- `Padrões predefinidos`
- `Fonte e texto`
- `Margens`
- `Opcao extra`
- `Campos do artigo`
- `Pronto para gerar`
- `Resumo da triagem`
- `Triagem do artigo`

### Coluna da esquerda

Blocos:

- `Documento e previa`
- arquivo carregado
- previa do texto
- destaque visual quando estiver em modo de selecao manual

### Campos do artigo

Divisao sugerida na interface:

- `Identificacao`
  - titulo PT
  - titulo EN
  - autor
  - instituicao
  - ORCID
  - e-mail

- `Resumo`
  - resumo
  - palavras-chave

- `Abstract`
  - abstract
  - keywords

---

## Regras de formatacao do Artigo

Com base no modelo analisado:

- fonte principal: `Bodoni MT`
- tamanho do texto: `12`
- tamanho compacto: `10`
- espacamento do texto: `1`
- espacamento compacto: `1`
- margens: `2 cm`
- `Antes = 0`
- `Depois = 0`

Observacao:

- o corpo pode ser formatado ja no primeiro ciclo
- cabecalho e rodape ainda dependem da fase de template editorial

---

## Camada futura de template editorial

O artigo modelo mostra que o preset `Artigo` precisara evoluir depois para um template mais completo.

Itens que pertencem a essa fase futura:

- `header1.xml`
- `header2.xml`
- `footer1.xml`
- `footer2.xml`
- imagens do cabecalho e rodape
- DOI
- datas editoriais
- citacao curta do rodape
- licenca
- primeira pagina especial

Decisao:

- essa camada fica registrada desde ja
- mas nao deve travar o primeiro ciclo de campos do corpo

---

## Ordem recomendada de implementacao

1. expandir o schema do preset `Artigo`
2. criar o painel `Campos do artigo`
3. renderizar estados visuais dos campos
4. implementar `structureHints`
5. implementar `extractionRules` simples
6. implementar mapeamento manual assistido por paragrafo
7. aplicar `mappingRules` no corpo do documento
8. manter a triagem integrada
9. planejar a camada de template editorial

---

## Decisoes registradas

- o `Artigo` sera o primeiro preset com campos
- o upload continua obrigatorio
- o primeiro ciclo foca no corpo do artigo
- o cabecalho e rodape ficam preparados como fase seguinte
- `Antes` e `Depois` devem permanecer zerados
- o sistema nao deve substituir conteudo silenciosamente quando a estrutura nao for reconhecida
- o usuario deve conseguir apontar o trecho certo na previa

