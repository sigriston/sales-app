# sales-app

[![Build Status](https://travis-ci.org/sigriston/sales-app.svg?branch=master)](https://travis-ci.org/sigriston/sales-app) [![Coverage Status](https://coveralls.io/repos/github/sigriston/sales-app/badge.svg?branch=master)](https://coveralls.io/github/sigriston/sales-app?branch=master)

Esta é uma aplicação simples de controle de vendas, feita para o [desafio de
programação Rails] da [Nama].

A aplicação oferece para o usuário um formulário de *upload* de arquivo através
do qual deve ser submetido um arquivo de texto contendo dados de vendas de uma
empresa fictícia. Após a submissão do arquivo, os dados são salvos no banco de
dados e é possível exibi-los na tela.

## Primeiros Passos

Seguem abaixo as instruções para obter uma cópia deste projeto em sua máquina
local, para fins de desenvolvimento e execução de testes. Confira a seção
**Deployment** para instruções de como instalar e executar a aplicação em
ambiente de produção.

### Pré-requisitos

* Ambiente **macOS** ou **Linux**
* Compilador C (como [gcc] ou [clang])
* [Ruby] versão 2.3 ou superior
* [Bundler] versão 1.14 ou superior
* [SQLite] versão 3
* [zlib]
* [Node.js]
* [PostgreSQL] (somente se quiser rodar em modo **PRODUÇÃO**)

**Dica**: no [Ubuntu] 16.04 é possível instalar todas as dependências acima
executando o script `ubuntu-install-deps.sh`.

### Instalação

Após clonar este repositório para sua máquina local, entre no diretório raiz do
repositório e instale as dependências da aplicação através do comando:

```console
$ bundle install --path vendor/bundle --without production
```

**Nota**: se quiser executar a aplicação localmente em modo produção, você irá
precisar do [PostgreSQL] instalado localmente. Neste caso, suprima o `--without
production` do comando `bundle install`.

Concluída a instalação, é preciso realizar a criação do banco de dados, com o
seguinte comando:

```console
$ bin/rails db:migrate
```

Após a criação do banco de dados, você poderá executar a aplicação através do
comando:

```console
$ bin/rails server
```

**Nota**: para modo produção, é preciso criar um banco de dados chamado
`salesapp_production` no PostgreSQL, e um usuário `salesapp` que possa
acessá-lo. Depois, os comandos são os seguintes:

```console
$ export SALESAPP_DATABASE_PASSWORD=senha_do_usuario_salesapp_do_postgresql
$ RAILS_ENV=production bin/rails db:migrate
$ bin/rails assets:precompile
$ SECRET_KEY_BASE=`bin/rails secret` RAILS_SERVE_STATIC_FILES=TRUE bin/rails server -e production
```

Feito isto, basta apontar o navegador para o endereço http://localhost:3000
para acessar a aplicação.

## Testes Automatizados

Para executar os testes automatizados, após as instruções de instalação
detalhadas na seção anterior, basta executar o seguinte comando:

```console
$ bin/rails test
```

**Nota:** ao executar os testes, é também contabilizada a cobertura de código
através da *gem* [SimpleCov].

## Documentação

Este projeto possui documentação extensiva no diretório `doc`. Recomenda-se
fortemente que contribuintes estudem essa documentação antes de realizar
mudanças no código, e que atualizem a documentação caso suas mudanças
necessitem.

## Deployment

Esta aplicação está preparada para *deployment* no [Heroku], bastando para
tanto seguir os passos na [documentação do Heroku para Rails 5].

## Contribuindo

Para contribuir com o projeto, o requerimento mínimo é a leitura do arquivo
[doc/principal.md], onde existe uma explicação de alto nível sobre a aplicação,
como ela está estruturada e como funciona.

## Autor

* Thiago Sigrist (@sigriston)

## Licença

MIT

[desafio de programação Rails]: https://github.com/9Nama/avaliacao_desenvolvedor
[Nama]: http://nama.ai
[Ruby]: https://www.ruby-lang.org
[Bundler]: http://bundler.io
[gcc]: https://gcc.gnu.org
[clang]: https://clang.llvm.org
[SQLite]: https://www.sqlite.org
[zlib]: http://zlib.net
[Node.js]: https://nodejs.org
[Ubuntu]: https://www.ubuntu.com/download/desktop
[SimpleCov]: https://github.com/colszowka/simplecov
[PostgreSQL]: https://www.postgresql.org
[Heroku]: https://www.heroku.com
[documentação do Heroku para Rails 5]: https://devcenter.heroku.com/articles/getting-started-with-rails5#deploy-your-application-to-heroku
[doc/principal.md]: doc/principal.md
