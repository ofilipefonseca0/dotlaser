DOT. LASER - MVP v6 cadastro avançado

Novidades:
- Atleta escolhe o tipo de gravação:
  1) 1 Nome + Tempo
  2) Nome + Sobrenome / texto personalizado
- Limite de caracteres nos campos.
- Campos de gravação em maiúsculo automático.
- Tempo formatado automaticamente: digite 015238 e vira 01:52:38.
- Token virou Voucher na interface.
- Antes de salvar, aparece uma tela de conferência do pedido.
- Comprovante mostra todos os atletas/gravações cadastradas.
- Download do comprovante completo com código visível e QR Code.
- QR Code aponta para URL inteligente /pedido/CODIGO.
- Painel entende QR Code com URL e extrai o código do pedido.

Como atualizar:
1. No Supabase, abra SQL Editor.
2. Cole e rode o conteúdo de schema-v6.sql.
3. No GitHub, substitua:
   - index.html
   - painel.html
   - README.txt
   - schema-v6.sql
4. Faça Commit changes.
5. Aguarde a Vercel republicar.

Observação:
O campo interno no banco continua usando team_token, mas na interface o nome exibido agora é Voucher.
