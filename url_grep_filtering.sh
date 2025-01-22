#!/bin/bash

# Arquivo com as URLs extraídas
input_file="urls.txt"

# Verificar se o arquivo de entrada existe
if [ ! -f "$input_file" ]; then
    echo "Arquivo $input_file não encontrado. Certifique-se de fornecer o arquivo correto."
    exit 1
fi

# Diretório para salvar os arquivos categorizados
output_dir="filtered_urls"
mkdir -p "$output_dir"

# Categorias e greps
# 1. URLs com redirecionamento
redirect_file="$output_dir/redirect_urls.txt"
grep -Ei "(redirect|next|url=)" "$input_file" > "$redirect_file"

# 2. URLs com potenciais vazamentos (tokens, keys, auth)
potential_leaks_file="$output_dir/potential_leaks.txt"
grep -Ei "(token=|key=|auth=|session)" "$input_file" > "$potential_leaks_file"

# 3. Arquivos sensíveis (.env, .config, .log, .json)
sensitive_files_file="$output_dir/sensitive_files.txt"
grep -Ei "\.(env|log|config|json|yml|yaml|bak)$" "$input_file" > "$sensitive_files_file"

# 4. URLs com parâmetros para fuzzing
param_file="$output_dir/parameterized_urls.txt"
grep -Ei "\?" "$input_file" > "$param_file"

# 5. Endpoints de API
api_file="$output_dir/api_endpoints.txt"
grep -Ei "/api/" "$input_file" > "$api_file"

# 6. Potenciais URLs de administração/administração
admin_file="$output_dir/admin_endpoints.txt"
grep -Ei "(admin|dashboard|login|manage)" "$input_file" > "$admin_file"

# 7. Potenciais arquivos JavaScript
javascript_file="$output_dir/javascript_files.txt"
grep -Ei "\.js$" "$input_file" > "$javascript_file"

# 8. Potenciais páginas HTML
html_file="$output_dir/html_pages.txt"
grep -Ei "\.html?$" "$input_file" > "$html_file"

# 9. URLs relacionadas a redefinição de senha
password_reset_file="$output_dir/password_reset_urls.txt"
grep -Ei "(reset_password|forgot|password_reset)" "$input_file" > "$password_reset_file"

# 10. URLs de autenticação
auth_file="$output_dir/authentication_urls.txt"
grep -Ei "(auth|authenticate|login|signin|signup)" "$input_file" > "$auth_file"

# Finalização
echo "Filtros aplicados com sucesso! Arquivos categorizados salvos no diretório $output_dir."
