DOT. LASER - MVP Supabase v3

Arquivos:
- schema.sql: estrutura inicial do banco. Se você já rodou o schema da v1/v2, não precisa rodar novamente.
- index.html: página pública do atleta com código do pedido e tela de sucesso.
- painel.html: painel interno com busca por código, nome, WhatsApp, tempo e status.

Atualização v3:
1. Código de pedido amigável, exemplo DOT-0001.
2. Tela de sucesso após confirmar cadastro.
3. Botão para copiar o código do pedido sem alert.
4. Busca do painel reforçada por código, nome, WhatsApp e tempo.

Para atualizar na Vercel:
1. Substitua os arquivos index.html e painel.html no GitHub.
2. Faça Commit changes.
3. A Vercel atualiza o site automaticamente.

Observação:
Esta versão ainda está com regras públicas de MVP no Supabase. Antes de usar em evento real, implementar login no painel.
