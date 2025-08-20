# Definição dos caracteres que podem ser utilizados na senha
# Variável caracteres -  @() é a sintaxe para criar um array no PowerShell.
$caracteres = @(
    'a','b','c','d','e','f','g','h','i','j','k','l','m',
    'n','o','p','q','r','s','t','u','v','w','x','y','z',
    'A','B','C','D','E','F','G','H','I','J','K','L','M',
    'N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
    '0','1','2','3','4','5','6','7','8','9',
    '!','@','#','$','%','&','*'
)

# Dia 12.08 - Mudança para que o usuário escolha qual o tamanho da senha
Write-Host "Qual tamanho da senha você deseja?" -ForegroundColor Yellow
$tamanhoSenha = [int](Read-Host)

# Variável que vai guardar a senha final
$senha = ""

# Tirar Simbolos
$simbolos = @('!','@','#','$','%','&','*')
$respostasimbolo = Read-Host "Deseja remover símbolos? (s/n)"
if ($respostasimbolo -eq 's') {
    $caracteres = $caracteres | Where-Object { $_ -notin $simbolos }
}

# Função para tirar caracteres parecidos
# Lista de caracteres parecidos
$caracteresParecidos = @('0','O','1','l')
$resposta = Read-Host "Quer remover caracteres parecidos como 0/O e 1/l? (s/n)"

# Resposta = "s", filtra o array principal removendo esses caracteres
# -eq siginfica equal/igual
# Where-Object - indica o local do objeto 
# -notin - não esteja em caracteres parecidos
# O | (pipeline) manda cada elemento do array $caracteres para dentro do Where-Object 
if ($resposta -eq 's') {
    $caracteres = $caracteres | Where-Object { $_ -notin $caracteresParecidos }
}

# Loop para escolher caracteres aleatórios e formar a senha
# $i começa em 0 e vai até o tamanho da senha
# lt = less than "menor que"
for ($i = 0; $i -lt $tamanhoSenha; $i++) {
    # Escolhe um índice aleatório dentro do array $caracteres
    $indiceAleatorio = Get-Random -Minimum 0 -Maximum $caracteres.Length

    # Adiciona o caractere escolhido à senha 
    # Ou seja, a senha "" estava vazia, será preenchida com os caracteres
    # += usado para acrescentar algo a uma variável já existente
    $senha += $caracteres[$indiceAleatorio]
}

# Mostrando a senha gerada para o usuário
Write-Output "|============= SENHA GERADA: $senha ==================|" 


# Copiar senha para copia
$copiar = Read-Host "Deseja copiar a senha para a área de transferência? (s/n)"
# ToLower - garante que tanto s ou S funcionem
# Value - indica o que será passado para a área de transferência
if ($copiar.ToLower() -eq 's') {
    Set-Clipboard -Value $senha
    Write-Host "Senha copiada para a área de transferência!" -ForegroundColor Green
}

# SALVANDO SENHA EM UM ARQUIVO
# Caminho do arquivo
# [Environment]::GetFolderPath("Desktop") - Caminho do Desktop do usuário atual
$desktop = [Environment]::GetFolderPath("Desktop")
$caminhoArquivo = Join-Path $desktop "senhas_geradas.txt"

# Linha a ser salva no arquivo 
# Get-Date - mostrar data e hora | -format = formato 
$senhaguardada = "$(Get-Date -Format 'dd-MM-yyyy HH:mm') - $senha"

# Salva no final do arquivo
# Add-Content, adiciona conteúdo sem apagar
Add-Content -Path $caminhoArquivo -Value $senhaguardada

# Mensagem de confirmação
Write-Host "Senha salva em: $caminhoArquivo" -ForegroundColor Yellow
