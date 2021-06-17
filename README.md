# p3-flutter

Link com o esquema de funcionamento do site: https://docs.google.com/drawings/d/1HXlsFHYpHYJ1fLVkuzJAhZRm3tzoKHNqCSyN53lqLOA/edit?usp=sharing

**Site deploy**: 
```
https://Amanda-Carmo.github.io/index.html
```

## Desenvolvimento

Essas instruções vão fazer com que você tenha uma cópia do projeto rodando em sua máquina local para desevolvimento.
Veja o tópico de [_deployment_](#deployment) para ver como subir o projeto nas lojas.

### Pré-Requisitos

Para executar o projeto, você precisa ter instalado em sua máquina: Flutter e Visual Studio. Que podem ser instaladas pelos métodos a seguir:

#### Visual Studio
Para instalação, seguir instruções no link
https://code.visualstudio.com/download

#### Flutter

- Linux

  ```
  https://flutter.dev/docs/get-started/install/linux
  ```

- Windows
  ```
  https://flutter.dev/docs/get-started/install/windows
  ```
  
- macOS
  ```
  https://flutter.dev/docs/get-started/install/macos
  ```
  
  
## Instalação e execução
 
### MacOS
**Instalação no Mac**
Para rodar o app no Mac, é preciso instalar, além o Android Studio e o Flutter, o XCode e o CocoaPods.
Para instalar o Android Studio, veja [_Android Studio_](#Android_Studio)

Para instalar o Xcode, é preciso fazer o download pela App Store. Para utilizar os comandos do terminal com o Xcode, utilize rode no terminal 
```
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

Em seguida, instale o CocoaPods com os comandos 
```
sudo gem install cocoapods
```
e 
```
pod setup
```

#### Rodando o app em um navegador
Para rodar o código, vá para o diretório do projeto. Você deve estar na pasta ‘simul_party’. Em seguida, rode 
```
flutter run
```
no terminal, digite o número correspondente ao navegador desejado.
 
### Windows
**Instalação**
Uma vez instalado o arquivo indicado no link indicado para o Windows, deve-se extrair o arquivo zipado e coloca-lo em um diretório como ``C:\src\flutter``, como indicado no site. 

Se você não deseja instalar a versão fixa do pacote de instalação, pode ignorar a etapa descrita acima e utilizar o comando a seguir para obter o código fonte do repositório do Flutter no GitHub:
```
C:\src>git clone https://github.com/flutter/flutter.git -b stable
```

Os próximos passos estão descritos no link dado.

#### Escolhendo editor

- VS Code:
No caso do VS Code, as instruções são dadas a seguir: https://flutter.dev/docs/get-started/editor?tab=vscode#vscode

O próximo passo, é checar se tudo roda de forma adequada. Para isso, no terminal do seu computador, entre no diretório onde foi colocado o flutter e rode o comando para checar se há alguma dependência que precise checar e configurar:
```
C:\src\flutter>flutter doctor
```

#### Rodando o aplicativo
Com o repositório clonado, no terminal, acesse a pasta simul_party, onde foi colocado o web app, e rode:

```
flutter run
```
No terminal, será pedido para escolher um navegador. Digite o número correspondente e espere até que se abra a página.

Após dar run pela primeira vez, pode-se precisar atualizar alguns pacotes. Neste caso, rode ``flutter packages upgrade`` no terminal do editor em uso.

O Flutter possui o recurso Stateful Hot Reload, que possibilita recarregar o código após uma alteração, sem que se perca o estado em que o app estava rodando. É possível utilizá-lo invocando Save All. No terminal, basta digitar "r".

mais informações de como rodar em: https://flutter.dev/docs/get-started/web

### Linux:
#### Instalação

Para obter o Flutter no Linux, a princípio deve-se instalar o Flutter SDK, como indicado no link: https://flutter.dev/docs/get-started/install/linux

use o seguinte link para extrair o arquivo zipado:
```
cd ~/development
tar xf ~/Downloads/flutter_linux_1.17.5-stable.tar.xz
```
Da mesma forma que no Windows, é possível clonar o repositório ao invés de obter o zip. Para isso, digite no terminal os seguinte comando:
```
git clone https://github.com/flutter/flutter.git
```
É possível alterar branches e tags conforme o necessário. Por exemplo, para obter apenas a versão estável:

```
git clone https://github.com/flutter/flutter.git -b stable --depth 1
```
Adicione flutter no path:
```
export PATH="$PATH:`pwd`/flutter/bin"
```

Depois, rode o seguinte comando para checar se o ambiente de desenvolvimento está em ordem com as instalações feitas e reporta no terminal. 

```
flutter doctor
``` 

#### Update path
A seguir estão os passos para modificar a variável permanentemente, como descrito no link a seguir:
https://flutter.dev/docs/get-started/install/linux#update-your-path

#### Update path diretamente:
Localize o diretório “etc”no root do sistema e abra o arquivo profile, como administrador. Rode:
```
  $ sudo nano /etc/profile
```
A seguir, atualize a string PATH do diretório do Flutter SDK:
```
if [ "`id -u`" -eq 0 ]; then
   PATH="..."
else
   PATH="/usr/local/bin:...:[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin"
fi
export PATH
```
Depois, finalize a sessão para rebootar o sistema. Depois, verifique se o flutter está disponível rodando: ´´which flutter´´. 



#### Configurando editor:

Para utilização do VS Code, siga as instruções dadas no link:
https://flutter.dev/docs/get-started/editor?tab=vscode#vscode


#### Rodando aplicativo:
As instruções são as mesmas dadas para o Windows e também podem ser vistas em https://flutter.dev/docs/get-started/test-drive?tab=androidstudio


