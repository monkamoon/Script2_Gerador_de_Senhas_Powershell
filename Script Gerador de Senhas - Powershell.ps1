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

# Definição do tamanho da senha, também variável
$tamanhoSenha = 15

# Variável que vai guardar a senha final
$senha = ""

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
Write-Output "Senha gerada: $senha"
