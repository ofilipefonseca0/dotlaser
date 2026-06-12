dot. laser - v8.1 Dashboard integrado ao admin

Domínios sugeridos:
- Página pública/atleta: https://www.dotlaser.com.br
- Painel administrativo: https://admin.dotlaser.com.br/admin.html
- Painel operacional: https://painel.dotlaser.com.br/painel.html

Arquivos para subir no GitHub:
- index.html
- login.html
- painel.html
- admin.html
- schema-v8.sql
- README.txt

Supabase:
1. Rode schema-v8.sql no SQL Editor.
2. Ele apenas recarrega o cache do Supabase/PostgREST; não altera tabelas.

Mudanças desta versão:
- Dashboard operacional foi integrado dentro do admin.html.
- Removida a necessidade de acessar dashboard.html separado.
- Botão "Dashboard" no topo do admin leva para a seção interna.
- Botão "Painel operacional" no admin aponta para https://painel.dotlaser.com.br/painel.html.
- Dashboard continua visível apenas para usuários com role admin.
- Mantém: eventos, cupons, vouchers, arquivados e exclusões com confirmação.

Observação:
Se quiser manter compatibilidade temporária, você pode deixar dashboard.html no GitHub, mas ele não é mais necessário para o fluxo principal.


v8.2:
- Adicionada opção Editar nos eventos dentro do painel admin.
- Permite alterar nome, prefixo, valor, data e gravação gratuita.
- Mantém ativar/desativar e excluir com confirmação.
