# sales-app

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

**Dica**: no [Ubuntu] 16.04 é possível instalar todas as dependências acima
executando o script `ubuntu-install-deps.sh`.

### Instalação

Após clonar este repositório para sua máquina local, entre no diretório raiz do
repositório e instale as dependências da aplicação através do comando:

```console
bundle install --path vendor/bundle
```

Concluída a instalação, você poderá executar a aplicação através do comando:

```console
./bin/rails server
```

Feito isto, basta apontar o navegador para o endereço http://localhost:3000
para acessar a aplicação.

## Testes Automatizados

Para executar os testes automatizados, após as instruções de instalação
detalhadas na seção anterior, basta executar o seguinte comando:

```console
./bin/rails test
```

**Nota:** ao executar os testes, é também contabilizada a cobertura de código
através da *gem* [SimpleCov].

## Documentação

Este projeto possui documentação extensiva no diretório `doc`. Recomenda-se
fortemente que contribuintes estudem essa documentação antes de realizar
mudanças no código, e que atualizem a documentação caso suas mudanças
necessitem.

## Deployment

**TODO**: documentar deployment.

## Contribuindo

**TODO**: documentar contribuição.

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
