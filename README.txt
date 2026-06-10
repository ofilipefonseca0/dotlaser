DOT. LASER - MVP v6.2

Mudanças desta versão:
- Cadastro simplificado: apenas Nome + Tempo de prova (opcional).
- Campo de nome em maiúsculo automático.
- Tempo formatado automaticamente ao digitar números.
- Termo "Token" substituído por "Voucher".
- Tela de conferência antes da confirmação definitiva.
- Comprovante com todos os atletas do pedido.
- QR Code com número de pedido visível no comprovante baixado.
- Painel administrativo para criar/desativar eventos.
- Página pública pode receber evento por URL: index.html?event=slug-do-evento.
- Painel de operação permite filtrar por evento.

Arquivos para subir no GitHub:
- index.html
- painel.html
- admin.html
- login.html
- schema-v62.sql
- README.txt

Antes de testar:
1. No Supabase, abra SQL Editor.
2. Rode o conteúdo de schema-v62.sql.
3. Suba os arquivos no GitHub.
4. Aguarde a Vercel atualizar.

Acesso:
- Cadastro do atleta: /index.html
- Painel operador: /painel.html
- Eventos/admin: /admin.html

Para criar evento:
1. Acesse /admin.html logado como operador.
2. Informe nome, prefixo, valor, data e cidade.
3. Use o link de cadastro gerado na tabela de eventos.
