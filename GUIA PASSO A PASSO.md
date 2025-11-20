# 📘 GUIA PASSO A PASSO - Cassino Opensource v10.5

**Versão:** 10.5  
**Sistema Operacional:** Windows  
**Ambiente:** Desenvolvimento Local  
**Última Atualização:** 2025-11-20

---

## 📋 Índice
1. [Credenciais de Acesso Rápido](#-credenciais-de-acesso-rápido)
2. [Requisitos do Sistema](#-requisitos-do-sistema)
3. [Instalação do Laragon](#-instalação-do-laragon)
4. [Estrutura do Projeto](#-estrutura-do-projeto)
5. [Instalação das Dependências](#-instalação-das-dependências)
6. [Configuração do Banco de Dados](#-configuração-do-banco-de-dados)
7. [Configuração do Ambiente Laravel](#-configuração-do-ambiente-laravel)
8. [Configuração de Credenciais de Login](#-configuração-de-credenciais-de-login)
9. [Inicialização do Servidor](#-inicialização-do-servidor)
10. [Verificação e Testes](#-verificação-e-testes)
11. [Solução de Problemas](#-solução-de-problemas)
12. [Checklist de Instalação](#-checklist-de-instalação-completa)

---

## 🔐 Credenciais de Acesso Rápido

### Login Padrão do Sistema

**Acesse:** http://localhost:8000

**Credenciais:**
- **Username:** `admin`
- **Password:** `admin`

### Todos os Usuários Disponíveis

Todos usam a senha **`admin`**:

| Username | Senha | Função | Painel |
|----------|-------|---------|--------|
| **admin** | admin | Administrador | /backend |
| **agent** | admin | Agente | /backend |
| **distributor** | admin | Distribuidor | /backend |
| **manager** | admin | Gerente | /backend |
| **cashier** | admin | Caixa | /backend |

### Como Fazer Login

1. Acesse **http://localhost:8000**
2. Clique em **"Log In"**
3. Digite: `admin` / `admin`
4. Você será redirecionado para o dashboard em `/backend`

---

## 🖥️ Requisitos do Sistema

### Hardware Mínimo
- **Processador:** Intel Core i3 ou equivalente
- **RAM:** 4 GB (8 GB recomendado)
- **Espaço em Disco:** 
  - 500 MB para Laragon
  - 500 MB para o projeto base
  - (Opcional) 40 GB para game packs completos (~1200 jogos)

### Software
- **Sistema Operacional:** Windows 10/11 (64-bit)
- **Navegador:** Chrome, Firefox, Edge (versões recentes)
- **Conexão com Internet:** Necessária para downloads iniciais

---

## 📦 Instalação do Laragon

### Passo 1: Download do Laragon

1. Acesse: https://laragon.org/download/
2. Baixe o **Laragon Full 2025 v8.3** (~240 MB)
   - Versão Full inclui: PHP, MySQL, Apache, Composer, HeidiSQL

### Passo 2: Instalação do Laragon

1. Execute o instalador `laragon-wamp.exe`
2. Escolha o diretório de instalação (padrão: `C:\laragon`)
3. Aceite as configurações padrão
4. Aguarde a instalação completar (~3-5 minutos)
5. **NÃO** inicie o Laragon ainda

### Passo 3: Verificação da Instalação

Confirme que os seguintes componentes estão instalados:
- ✅ PHP 8.3.26 em: `C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\`
- ✅ MySQL 8.4.3 em: `C:\laragon\bin\mysql\mysql-8.4.3-winx64\`
- ✅ Composer em: `C:\laragon\bin\composer\`
- ✅ Node.js / NPM (se incluído na versão Full)

---

## 📁 Estrutura do Projeto

### Download do Projeto

1. Baixe o projeto Cassino Opensource v10.5
2. Extraia para um diretório, exemplo:
   ```
   C:\Users\[SeuUsuario]\Downloads\opensource-casino-v10-main\
   ```

### Estrutura de Diretórios (Importante!)

O projeto tem uma estrutura **NÃO PADRÃO**:

```
opensource-casino-v10-main/           ← ROOT (public directory)
├── index.php                         ← Entry point
├── .htaccess                         ← Apache rewrite rules
│
├── casino/                           ← Laravel Application
│   ├── app/                          ← Application logic
│   ├── config/                       ← Configuration files
│   ├── database/
│   ├── resources/                    ← Views, assets
│   ├── routes/                       ← Route definitions
│   ├── storage/                      ← Logs, cache
│   ├── vendor/                       ← PHP dependencies (após composer install)
│   ├── node_modules/                 ← JS dependencies (após npm install)
│   ├── .env                          ← Environment config (criar)
│   ├── composer.json
│   └── package.json
│
├── frontend/                         ← Frontend assets
├── woocasino/                        ← WooCommerce integration
├── uploads/                          ← User uploads
└── v105.sql                          ← Database SQL file
```

> **⚠️ CRÍTICO:** O diretório raiz (`opensource-casino-v10-main`) é o **public directory**, não `casino/public`. O `index.php` na raiz já redireciona corretamente para o Laravel.

---

## 🔧 Instalação das Dependências

### Passo 1: Abrir Terminal no Diretório do Projeto

Abra o PowerShell ou CMD em:
```
C:\Users\[SeuUsuario]\Downloads\opensource-casino-v10-main\casino
```

### Passo 2: Instalar Dependências PHP (Composer)

Execute o comando:
```powershell
C:\laragon\bin\composer\composer.bat install
```

**Tempo estimado:** 2-5 minutos  
**Resultado esperado:**
- Criação da pasta `vendor/` com 1212 pacotes PHP
- Mensagens de sucesso do Composer

**Possíveis avisos:**
- Mensagens sobre `vlucas/phpdotenv` são normais
- Avisos de deprecação podem ser ignorados para desenvolvimento local

### Passo 3: Instalar Dependências Node.js (NPM)

> **Nota:** Se o Laragon Full não incluir Node.js, baixe de https://nodejs.org/ (versão LTS)

Execute:
```powershell
npm install
```

**Tempo estimado:** 3-10 minutos  
**Resultado esperado:**
- Criação da pasta `node_modules/` com 1212 pacotes
- 81 vulnerabilidades detectadas são normais (não crítico para desenvolvimento)

### Passo 4: Instalar PM2 (Gerenciador de Processos)

```powershell
npm install -g pm2
```

**Uso:** PM2 é necessário para gerenciar os serviços WebSocket dos jogos em tempo real (opcional para setup inicial).

---

## 🗄️ Configuração do Banco de Dados

### Passo 1: Iniciar MySQL

1. Abra o Laragon
2. Clique em **"Start All"**
3. Aguarde os serviços iniciarem (ícones ficam verdes)
4. MySQL estará rodando na porta **3306**

### Passo 2: Criar o Banco de Dados

Opção A - Via Laragon UI:
1. Clique com botão direito em **"MySQL"** no Laragon
2. Selecione **"MySQL console"** ou **"HeidiSQL"**

Opção B - Via Linha de Comando:
```powershell
C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe -u root
```

Execute no console MySQL:
```sql
CREATE DATABASE casino_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EXIT;
```

### Passo 3: Importar o Arquivo SQL

Localize o arquivo `v105.sql` (8 MB) no diretório raiz do projeto.

Execute:
```powershell
C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe -u root casino_db < v105.sql
```

**Tempo estimado:** 10-30 segundos  
**Resultado esperado:** Importação silenciosa sem erros

### Passo 4: Verificar Importação

```powershell
C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe -u root -e "USE casino_db; SHOW TABLES;"
```

**Resultado esperado:** Lista de ~50 tabelas, incluindo:
- `w_users`
- `w_games`
- `w_categories`
- `w_transactions`
- etc.

---

## ⚙️ Configuração do Ambiente Laravel

### Passo 1: Criar Arquivo .env

Navegue para:
```
C:\Users\[SeuUsuario]\Downloads\opensource-casino-v10-main\casino\
```

Copie o arquivo de exemplo:
```powershell
Copy-Item .env.example .env
```

### Passo 2: Editar Configurações do .env

Abra `.env` em um editor de texto e configure:

```ini
APP_NAME="Cassino Opensource"
APP_ENV=local
APP_KEY=                    # Será gerado no próximo passo
APP_DEBUG=true
APP_URL=http://localhost:8000

LOG_CHANNEL=stack
LOG_LEVEL=debug

# Database
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=casino_db
DB_USERNAME=root
DB_PASSWORD=                # Vazio (padrão Laragon)

# Cache & Session
CACHE_DRIVER=file
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

# Broadcasting (WebSocket - configurar depois)
BROADCAST_DRIVER=log
```

### Passo 3: Gerar Application Key

```powershell
C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe artisan key:generate
```

**Resultado esperado:**
```
Application key set successfully.
```

Verifique que `APP_KEY` no `.env` agora tem um valor como:
```
APP_KEY=base64:randomstring...
```

### Passo 4: Configurar Permissões de Diretório

Garantir que o Laravel pode escrever em `storage/` e `bootstrap/cache/`:

```powershell
# Criar diretórios se não existirem
New-Item -ItemType Directory -Force -Path storage\framework\sessions
New-Item -ItemType Directory -Force -Path storage\framework\views
New-Item -ItemType Directory -Force -Path storage\framework\cache
New-Item -ItemType Directory -Force -Path storage\logs
New-Item -ItemType Directory -Force -Path bootstrap\cache
```

### Passo 5: Limpar Cache (Opcional)

```powershell
C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe artisan cache:clear
C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe artisan config:clear
C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe artisan view:clear
```

---

## 🔐 Configuração de Credenciais de Login

### Problema Comum: Senhas Inválidas no Banco

O arquivo SQL importado pode conter hashes de senha inválidos ou desconhecidos. É necessário redefinir as senhas para valores conhecidos.

### Solução: Definir Senha Simples "admin/admin"

#### Passo 1: Gerar Hash Bcrypt

Gere um hash bcrypt para a senha "admin":

```powershell
C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe -r "echo password_hash('admin', PASSWORD_BCRYPT) . PHP_EOL;"
```

**Resultado esperado** (exemplo):
```
$2y$10$cMli0FX/KVWn4ewJpkeN7uO8TquFJeROCWxodK/22mbrn7c/URgVm
```

> **⚠️ IMPORTANTE:** O hash será diferente cada vez, mas ambos validarão a mesma senha "admin".

#### Passo 2: Criar Script SQL

Crie um arquivo `set_passwords.sql` no diretório raiz do projeto:

```sql
UPDATE w_users SET password = '$2y$10$cMli0FX/KVWn4ewJpkeN7uO8TquFJeROCWxodK/22mbrn7c/URgVm';
SELECT id, username, LENGTH(password) as pwd_length FROM w_users LIMIT 5;
```

> **⚠️ CRÍTICO:** Substitua o hash acima pelo hash gerado no Passo 1.

#### Passo 3: Executar Script

```powershell
Get-Content set_passwords.sql | C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe -u root casino_db
```

**Resultado esperado:**
```
id      username        pwd_length
1       admin           60
2       agent           60
3       distributor     60
4       manager         60
5       cashier         60
```

> **✅ VERIFICAÇÃO CRÍTICA:** O `pwd_length` **DEVE** ser exatamente **60** caracteres. Se for menor (46, 48, 49), o hash não foi inserido corretamente e o erro "[object Object]" aparecerá no login.

#### Passo 4: Credenciais Configuradas

Após este processo, todos os usuários terão a senha **`admin`**:

| Username | Password | Função | Painel |
|----------|----------|--------|--------|
| admin | admin | Administrador | /backend |
| agent | admin | Agente | /backend |
| distributor | admin | Distribuidor | /backend |
| manager | admin | Gerente | /backend |
| cashier | admin | Caixa | /backend |

---

## 🚀 Inicialização do Servidor

### Método: Servidor PHP Built-in

> **Nota:** Para desenvolvimento local, usaremos o servidor embutido do PHP. Para produção, use Apache ou Nginx.

#### Passo 1: Navegar para o Diretório Raiz

```powershell
cd C:\Users\[SeuUsuario]\Downloads\opensource-casino-v10-main
```

> **⚠️ IMPORTANTE:** Deve ser o diretório raiz (`opensource-casino-v10-main`), NÃO `casino/`.

#### Passo 2: Iniciar o Servidor

```powershell
C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe -S localhost:8000
```

**Resultado esperado:**
```
[Wed Nov 20 13:00:00 2025] PHP 8.3.26 Development Server (http://localhost:8000) started
```

> **🔴 DEIXE ESTE TERMINAL ABERTO** enquanto usar a aplicação.

#### Passo 3: Verificar Servidor Rodando

Abra o navegador em: **http://localhost:8000**

---

## ✅ Verificação e Testes

### Teste 1: Acesso à Página Inicial

1. Abra o navegador
2. Acesse: **http://localhost:8000**
3. Verifique:
   - ✅ Página carrega sem erros 500/404
   - ✅ Botões "Register" e "Log In" visíveis
   - ✅ Slider de banner principal aparece
   - ✅ Lista de provedores (netent, playtech, pragmatic, etc.)
   - ✅ Grade de jogos exibida
   - ✅ Laravel Debug Bar visível na parte inferior (se `APP_DEBUG=true`)

### Teste 2: Login no Sistema

1. Clique em **"Log In"**
2. Insira credenciais:
   - **Username:** `admin`
   - **Password:** `admin`
3. Clique em **"Login"**
4. Verifique:
   - ✅ Redirecionamento para: `http://localhost:8000/backend`
   - ✅ Dashboard de administração carrega
   - ✅ Menu lateral com opções administrativas
   - ✅ Sem erros "[object Object]" em vermelho

### Teste 3: Navegação pelo Sistema

Teste as seguintes páginas:
- `/backend` - Dashboard principal
- `/categories/all` - Lista de categorias de jogos
- `/categories/netent` - Jogos NetEnt
- `/games` - Lista completa de jogos

---

## 🛠️ Solução de Problemas

### Problema 1: Erro 500 - Internal Server Error

**Sintomas:**
- Página em branco
- Erro 500 ao acessar qualquer rota

**Soluções:**

1. **Verificar permissões do diretório `storage/`:**
   ```powershell
   # Garantir que storage/ é gravável
   icacls storage /grant Everyone:F /T
   ```

2. **Verificar se `APP_KEY` foi gerado:**
   ```powershell
   C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe artisan key:generate
   ```

3. **Verificar logs:**
   ```powershell
   Get-Content casino\storage\logs\laravel.log | Select-Object -Last 50
   ```

### Problema 2: Erro de Conexão com Banco de Dados

**Sintomas:**
- `SQLSTATE[HY000] [2002] Connection refused`
- `Access denied for user 'root'@'localhost'`

**Soluções:**

1. **Verificar se MySQL está rodando:**
   - Abra Laragon e clique em "Start All"

2. **Verificar credenciais no `.env`:**
   ```ini
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=casino_db
   DB_USERNAME=root
   DB_PASSWORD=
   ```

3. **Testar conexão manualmente:**
   ```powershell
   C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe -u root -e "SHOW DATABASES;"
   ```

### Problema 3: Login Mostra "[object Object]" em Vermelho

**Sintomas:**
- Formulário de login exibe múltiplas linhas de `[object Object]` em vermelho
- Login não funciona

**Causa:**
- Hash de senha no banco de dados está incorreto ou com comprimento inválido (não tem 60 caracteres)

**Solução:**

1. **Verificar comprimento do hash:**
   ```powershell
   C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe -u root casino_db -e "SELECT id, username, LENGTH(password) as pwd_len FROM w_users LIMIT 5;"
   ```

2. **Se `pwd_len` não for 60, refaça a configuração de senhas:**
   - Volte para seção [Configuração de Credenciais de Login](#-configuração-de-credenciais-de-login)
   - Gere um novo hash
   - Crie e execute o script SQL usando `Get-Content` + pipe:
     ```powershell
     Get-Content set_passwords.sql | C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe -u root casino_db
     ```

3. **Limpar cache de aplicação:**
   ```powershell
   cd casino
   C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe artisan cache:clear
   C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe artisan config:clear
   ```

### Problema 4: Página em Branco ou Assets Não Carregam

**Sintomas:**
- CSS/JS não carregam
- Imagens quebradas
- Console do navegador mostra erros 404

**Soluções:**

1. **Verificar diretório público:**
   - Certifique-se de que está iniciando o servidor no diretório RAIZ (`opensource-casino-v10-main`), não em `casino/`

2. **Compilar assets (se necessário):**
   ```powershell
   cd casino
   npm run dev
   ```

3. **Verificar permissões:**
   ```powershell
   icacls uploads /grant Everyone:F /T
   ```

### Problema 5: Porta 8000 Já em Uso

**Sintomas:**
```
Address already in use
```

**Soluções:**

1. **Usar outra porta:**
   ```powershell
   C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe -S localhost:8080
   ```
   E atualize `APP_URL` no `.env` para `http://localhost:8080`

2. **Encontrar e matar processo na porta 8000:**
   ```powershell
   netstat -ano | findstr :8000
   taskkill /PID [PID] /F
   ```

---

## 📝 Checklist de Instalação Completa

Use este checklist para confirmar que tudo está instalado corretamente:

### Ambiente
- [ ] Laragon 2025 v8.3 instalado
- [ ] PHP 8.3.26 disponível
- [ ] MySQL 8.4.3 rodando
- [ ] Composer instalado
- [ ] Node.js e NPM instalados
- [ ] PM2 instalado globalmente

### Projeto
- [ ] Projeto extraído no diretório correto
- [ ] `composer install` executado (1212 pacotes)
- [ ] `npm install` executado (1212 pacotes)
- [ ] Estrutura de diretórios compreendida

### Banco de Dados
- [ ] Banco `casino_db` criado
- [ ] Arquivo `v105.sql` importado
- [ ] Tabelas verificadas (`SHOW TABLES`)
- [ ] Senhas de usuários configuradas (hash com 60 caracteres)

### Configuração
- [ ] Arquivo `.env` criado e configurado
- [ ] `APP_KEY` gerado
- [ ] `APP_NAME` definido como "Cassino Opensource"
- [ ] Configurações de DB no `.env` corretas
- [ ] Permissões de `storage/` configuradas
- [ ] Cache limpo

### Servidor
- [ ] Servidor PHP iniciado em localhost:8000
- [ ] Página inicial carrega sem erro 500
- [ ] Login funciona com admin/admin
- [ ] Redirecionamento para `/backend` após login
- [ ] Dashboard de administração acessível

### Testes
- [ ] Página inicial mostra jogos e provedores
- [ ] Login bem-sucedido sem erro "[object Object]"
- [ ] Navegação entre categorias funciona
- [ ] Laravel Debug Bar visível (se debug ativo)

---

## 🎮 Configurações Opcionais

### WebSocket para Jogos em Tempo Real

#### Passo 1: Configurar Certificados SSL

Os serviços WebSocket requerem certificados SSL (mesmo que auto-assinados para desenvolvimento).

1. Navegue para:
   ```
   C:\Users\[SeuUsuario]\Downloads\opensource-casino-v10-main\casino\PTWebSocket\ssl\
   ```

2. Gere certificados auto-assinados (requer OpenSSL):
   ```powershell
   openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
   ```

#### Passo 2: Iniciar Serviços PM2

```powershell
cd casino\PTWebSocket
pm2 start Arcade.js --watch
pm2 start Server.js --watch
pm2 start Slots.js --watch
```

#### Passo 3: Verificar Status

```powershell
pm2 list
pm2 logs
```

---

## 🔒 Recomendações de Segurança

> **⚠️ WARNING**  
> **Apenas para Desenvolvimento Local**
> 
> Esta configuração é APENAS para ambiente de desenvolvimento local. Para produção:

1. **Altere todas as senhas padrão**
   - Use senhas fortes e únicas
   - Considere autenticação de dois fatores

2. **Configure `.env` para produção:**
   ```ini
   APP_ENV=production
   APP_DEBUG=false
   ```

3. **Use servidor web adequado:**
   - Apache com mod_rewrite
   - Nginx com PHP-FPM
   - Nunca use `php -S` em produção

4. **Configure HTTPS:**
   - Certificado SSL válido
   - Force redirecionamento HTTPS

5. **Firewall e permissões:**
   - Restrinja acesso ao banco de dados
   - Configure firewall adequado
   - Permissões mínimas em diretórios

---

## 💡 Dicas Adicionais

### Gerar Novo Hash de Senha

Você pode gerar novos hashes bcrypt via PHP:

```powershell
C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe -r "echo password_hash('sua_senha_aqui', PASSWORD_BCRYPT);"
```

Ou use o site: https://bcrypt-generator.com/

### Criar Novo Usuário

Para criar um novo usuário diretamente no banco:

```sql
INSERT INTO w_users (username, password, email, role_id, status) 
VALUES ('novouser', '$2y$10$HASH_BCRYPT_AQUI', 'email@example.com', 1, 'Active');
```

---

## ✅ Conclusão

Seguindo este guia, você deve ter:
- ✅ Ambiente de desenvolvimento completo instalado
- ✅ Cassino Opensource v10.5 rodando em localhost:8000
- ✅ Acesso administrativo ao sistema (admin/admin)
- ✅ Todos os componentes configurados e funcionando
- ✅ Conhecimento para solucionar problemas comuns

**Acesse agora:** http://localhost:8000

**Login padrão:**
- Username: `admin`
- Password: `admin`

---

## 📞 Suporte

Se encontrar problemas não cobertos neste guia:
1. Verifique a seção [Solução de Problemas](#-solução-de-problemas)
2. Consulte os logs em `casino/storage/logs/laravel.log`
3. Revise o checklist de instalação completa
4. Verifique se todos os serviços estão rodando (Laragon → MySQL + PHP)

---

**Documento criado em:** 2025-11-20  
**Versão do Guia:** 1.0  
**Testado em:** Windows 11, Laragon 2025 v8.3, PHP 8.3.26, MySQL 8.4.3  
**Sistema:** Cassino Opensource v10.5

---

## 🤖 PROMPT PARA INSTALAÇÃO AUTOMÁTICA COM IA

### Para Claude Sonnet 3.5 / 4.0

Copie e cole o prompt abaixo para que a IA execute automaticamente toda a instalação do Cassino Opensource v10.5:

---

```
Você é um assistente especializado em instalação de sistemas Laravel. Preciso que você instale e configure completamente o projeto "Cassino Opensource v10.5" no meu sistema Windows seguindo EXATAMENTE os passos abaixo.

CONTEXTO DO PROJETO:
- Sistema: Cassino Opensource v10.5 (Laravel 11)
- Plataforma: Windows 10/11
- Ambiente: Desenvolvimento local
- Diretório do projeto: C:\Users\[MEU_USUARIO]\Downloads\opensource-casino-v10-main

ESTRUTURA CRÍTICA:
O projeto tem estrutura NÃO PADRÃO onde a raiz "opensource-casino-v10-main" é o public directory, e "casino/" contém a aplicação Laravel.

OBJETIVO FINAL:
Sistema funcionando em http://localhost:8000 com login admin/admin acessível.

EXECUTE OS SEGUINTES PASSOS SEQUENCIALMENTE:

═══════════════════════════════════════════════════════════════════

FASE 1: INSTALAÇÃO DO LARAGON
═══════════════════════════════════════════════════════════════════

1. Verifique se o Laragon 2025 v8.3 está instalado em C:\laragon
   - Se NÃO estiver: Baixe de https://laragon.org/download/ e instale
   - Se já estiver: Prossiga para próxima etapa

2. Verifique se os seguintes componentes existem:
   - C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe
   - C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe
   - C:\laragon\bin\composer\composer.bat

═══════════════════════════════════════════════════════════════════

FASE 2: INSTALAÇÃO DE DEPENDÊNCIAS DO PROJETO
═══════════════════════════════════════════════════════════════════

3. Navegue para: C:\Users\[ATUALIZAR_COM_MEU_USUARIO]\Downloads\opensource-casino-v10-main\casino

4. Execute o Composer install:
```powershell
C:\laragon\bin\composer\composer.bat install
```
Aguarde conclusão (~2-5 minutos, 1212 pacotes)

5. Execute o NPM install:
```powershell
npm install
```
Aguarde conclusão (~3-10 minutos, 1212 pacotes)
NOTA: 81 vulnerabilidades são normais para desenvolvimento

6. Instale PM2 globalmente:
```powershell
npm install -g pm2
```

═══════════════════════════════════════════════════════════════════

FASE 3: CONFIGURAÇÃO DO BANCO DE DADOS
═══════════════════════════════════════════════════════════════════

7. Inicie o Laragon e todos os serviços (MySQL deve estar na porta 3306)

8. Crie o banco de dados:
```powershell
C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe -u root -e "CREATE DATABASE casino_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
```

9. Importe o arquivo SQL (volte para o diretório raiz):
```powershell
cd C:\Users\[ATUALIZAR_COM_MEU_USUARIO]\Downloads\opensource-casino-v10-main
C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe -u root casino_db < v105.sql
```

10. Verifique a importação:
```powershell
C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe -u root -e "USE casino_db; SHOW TABLES;"
```
ESPERADO: Lista de ~50 tabelas incluindo w_users, w_games, w_categories

═══════════════════════════════════════════════════════════════════

FASE 4: CONFIGURAÇÃO DO LARAVEL
═══════════════════════════════════════════════════════════════════

11. Navegue para: C:\Users\[ATUALIZAR_COM_MEU_USUARIO]\Downloads\opensource-casino-v10-main\casino

12. Copie o arquivo .env:
```powershell
Copy-Item .env.example .env
```

13. Edite o arquivo .env com as seguintes configurações:
```ini
APP_NAME="Cassino Opensource"
APP_ENV=local
APP_DEBUG=true
APP_URL=http://localhost:8000

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=casino_db
DB_USERNAME=root
DB_PASSWORD=

CACHE_DRIVER=file
SESSION_DRIVER=file
BROADCAST_DRIVER=log
```

14. Gere a Application Key:
```powershell
C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe artisan key:generate
```

15. Crie os diretórios necessários:
```powershell
New-Item -ItemType Directory -Force -Path storage\framework\sessions
New-Item -ItemType Directory -Force -Path storage\framework\views
New-Item -ItemType Directory -Force -Path storage\framework\cache
New-Item -ItemType Directory -Force -Path storage\logs
New-Item -ItemType Directory -Force -Path bootstrap\cache
```

16. Limpe o cache:
```powershell
C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe artisan cache:clear
C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe artisan config:clear
```

═══════════════════════════════════════════════════════════════════

FASE 5: CONFIGURAÇÃO DE CREDENCIAIS (CRÍTICO!)
═══════════════════════════════════════════════════════════════════

17. Gere um hash bcrypt para a senha "admin":
```powershell
C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe -r "echo password_hash('admin', PASSWORD_BCRYPT) . PHP_EOL;"
```
SALVE O HASH GERADO (tem exatamente 60 caracteres)

18. Crie arquivo set_passwords.sql na RAIZ do projeto com:
```sql
UPDATE w_users SET password = 'COLE_AQUI_O_HASH_DO_PASSO_17';
SELECT id, username, LENGTH(password) as pwd_length FROM w_users LIMIT 5;
```

19. Execute o script SQL:
```powershell
cd C:\Users\[ATUALIZAR_COM_MEU_USUARIO]\Downloads\opensource-casino-v10-main
Get-Content set_passwords.sql | C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe -u root casino_db
```

20. VERIFICAÇÃO CRÍTICA - O resultado DEVE mostrar:
```
pwd_length: 60
```
Se for diferente de 60 (ex: 46, 48, 49), REPITA os passos 17-19!

═══════════════════════════════════════════════════════════════════

FASE 6: INICIALIZAÇÃO DO SERVIDOR
═══════════════════════════════════════════════════════════════════

21. Navegue para o diretório RAIZ (não casino/):
```powershell
cd C:\Users\[ATUALIZAR_COM_MEU_USUARIO]\Downloads\opensource-casino-v10-main
```

22. Inicie o servidor PHP built-in:
```powershell
C:\laragon\bin\php\php-8.3.26-Win32-vs16-x64\php.exe -S localhost:8000
```
DEIXE ESTE TERMINAL ABERTO!

═══════════════════════════════════════════════════════════════════

FASE 7: TESTES E VERIFICAÇÃO
═══════════════════════════════════════════════════════════════════

23. Abra o navegador em: http://localhost:8000

24. Verifique:
    ✅ Página carrega sem erro 500/404
    ✅ Botões "Register" e "Log In" visíveis
    ✅ Jogos e provedores aparecem

25. Teste o login:
    - Clique em "Log In"
    - Username: admin
    - Password: admin
    - Clique em "Login"

26. Após login deve:
    ✅ Redirecionar para http://localhost:8000/backend
    ✅ Dashboard de administração carrega
    ✅ SEM erro "[object Object]" em vermelho

═══════════════════════════════════════════════════════════════════

SOLUÇÃO DE PROBLEMAS COMUNS
═══════════════════════════════════════════════════════════════════

SE ERRO 500:
- Verifique APP_KEY foi gerado no .env
- Execute: icacls storage /grant Everyone:F /T
- Verifique logs: Get-Content casino\storage\logs\laravel.log | Select-Object -Last 50

SE ERRO "[object Object]" NO LOGIN:
- O hash da senha NÃO tem 60 caracteres
- Repita FASE 5 completamente
- Use Get-Content + pipe no passo 19

SE ERRO DE CONEXÃO COM BANCO:
- Verifique se Laragon está rodando
- Teste: C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe -u root -e "SHOW DATABASES;"

SE ASSETS NÃO CARREGAM:
- Certifique-se de iniciar servidor no diretório RAIZ (opensource-casino-v10-main)
- NÃO inicie servidor dentro de casino/

═══════════════════════════════════════════════════════════════════

RESULTADO ESPERADO
═══════════════════════════════════════════════════════════════════

✅ Sistema rodando em http://localhost:8000
✅ Login funcionando: admin/admin
✅ Dashboard administrativo acessível em /backend
✅ Sem erros no navegador ou terminal
✅ Todos os 5 usuários (admin, agent, distributor, manager, cashier) com senha "admin"

═══════════════════════════════════════════════════════════════════

IMPORTANTE: 
- Execute CADA passo na ordem exata
- Aguarde conclusão de cada comando antes de prosseguir
- Verifique cada saída/resultado esperado
- Se algum passo falhar, PARE e reporte o erro antes de continuar
- NÃO pule a verificação do hash de 60 caracteres (Passo 20)
- Sempre use caminhos completos do Laragon
- Diretório raiz para servidor: opensource-casino-v10-main (NÃO casino/)

COMECE AGORA A INSTALAÇÃO!
```

---

### 📝 Como Usar Este Prompt

1. **Copie** todo o conteúdo do bloco de código acima
2. **Atualize** `[MEU_USUARIO]` com seu nome de usuário do Windows
3. **Cole** no chat com Claude Sonnet 3.5 ou 4.0
4. **Aguarde** a IA executar todos os passos
5. **Monitore** as saídas e verificações

### ⚠️ Observações Importantes

- A IA executará comandos automaticamente via `run_command`
- Alguns passos podem requerer aprovação (comandos não-safe)
- A IA pode usar o navegador via `browser_subagent` para testar
- Tempo total estimado: 15-30 minutos
- A IA irá reportar erros e solicitar intervenção se necessário

### 🎯 Verificação Final pela IA

A IA deve confirmar ao final:
- ✅ Servidor rodando
- ✅ Login testado com sucesso
- ✅ Dashboard acessível
- ✅ Nenhum erro crítico

---

**FIM DO DOCUMENTO**
