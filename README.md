# Formatador de Documentos Word

Aplicacao web (frontend puro) para receber arquivos `.docx`, aplicar padroes de formatacao e baixar um novo documento formatado.

O projeto foi pensado para uso institucional, com dois modos principais:

- `ABNT`: formatacao visual direta
- `Artigo`: formatacao + leitura assistida de campos + triagem

## O que o sistema faz hoje

- Upload e substituicao de arquivo `.docx` por drag and drop
- Previa do conteudo na mesma tela
- Presets de formatacao (`ABNT` e `Artigo`)
- Aplicacao de fonte, tamanhos, espacamentos, recuos, margens e alinhamento
- Modo `Artigo` com:
  - campos guiados (titulo, autor, resumo, abstract, keywords, dados editoriais)
  - extracao automatica inicial
  - mapeamento manual por paragrafo (`Selecionar no documento`)
  - triagem de conformidade para acelerar revisao humana
  - aplicacao de template editorial (header/footer da revista)
  - suporte a DOI, datas editoriais e citacao curta
  - normalizacao de rotulos no corpo (`RESUMO`, `PALAVRAS-CHAVE`, `ABSTRACT`, `KEYWORDS`)

## Stack

- HTML + CSS + JavaScript (arquivo principal: `format.html`)
- [JSZip](https://stuk.github.io/jszip/) para leitura/escrita do `.docx` no navegador
- Nginx (deploy estatico via Docker)

## Estrutura do repositorio

- `format.html`: interface, logica de presets, leitura da previa, engine DOCX e triagem
- `templates/artigo-modelo-base.docx`: base editorial do preset `Artigo`
- `Dockerfile` e `docker-compose.yml`: containerizacao

## Como rodar localmente

1. Entre na pasta do projeto.
2. Suba um servidor HTTP local (nao abra por `file://`).

Exemplo:

```powershell
python -m http.server 8080
```

Depois acesse:

- [http://localhost:8080/format.html](http://localhost:8080/format.html)

Observacao: o preset `Artigo` usa leitura de template por `fetch`, por isso precisa de HTTP local.

## Rodar com Docker

```powershell
docker compose up -d --build
```

Com o `docker-compose.yml` atual, o container sobe com Nginx interno na porta `80`, mas **nao publica uma porta no host por padrao**. Esse compose foi preparado para uso em Portainer, proxy reverso ou rede Docker compartilhada.

Se voce quiser validar localmente no navegador sem alterar o compose, o caminho mais simples continua sendo:

```powershell
python -m http.server 8080
```

Se precisar expor localmente via Docker, adicione temporariamente um mapeamento de portas no `docker-compose.yml`, por exemplo:

```yml
ports:
  - "8080:80"
```

## Status atual

Concluido:

- base de presets com `ABNT` e `Artigo`
- campos dinamicos do `Artigo`
- extracao automatica inicial + nivel de reconhecimento
- mapeamento manual assistido por paragrafo
- aplicacao pontual no DOCX com preservacao de runs
- camada editorial (template, header/footer, DOI, datas e citacao curta)
- melhorias de UX (toasts, modo personalizado, abas, dropzone ampla, CTA mobile)

Parcial:

- schema de `validations` extensivel por preset (ha triagem do `Artigo`, mas nao existe schema geral formalizado no preset)
- `mappingRules` declarativo por preset (ha aplicacao por `sourceRef` e regras editoriais, mas nao um bloco unico formal no schema)
- modularizacao de codigo (blocos logicos existem, mas ainda em arquivo unico)

Pendente:

- preset institucional novo `Despacho de bens`
- niveis de mapeamento manual por selecao fina de texto (alem do paragrafo inteiro)
- camada opcional de backend/API para geracao institucional (ex.: numeracao oficial)

## Observacoes de deploy

- O `index.html` e a entrada principal servida pelo Nginx e redireciona automaticamente para `format.html`
- O `docker-compose.yml` atual usa `expose: 80`, sem publicacao direta no host
- A exposicao publica final depende do ambiente de deploy (Portainer, proxy reverso ou publicacao manual de porta)
