DOT. LASER MVP v7.4

Novidades:
- Área Cupons de desconto no admin.html
- Criar/listar/ativar/desativar cupons
- Área Vouchers de assessoria no admin.html
- Criar/listar/ativar/desativar vouchers

Como atualizar:
1. Rode schema-v74.sql no Supabase > SQL Editor > New Query > Run.
2. Substitua no GitHub:
   - admin.html
   - schema-v74.sql
   - README.txt
3. Aguarde a Vercel atualizar.
4. Acesse admin.html com usuário admin.

Observação:
- Cupom percentual: tipo Percentual, valor 10 = 10% OFF.
- Cupom fixo: tipo Valor fixo, valor 5 = R$ 5,00 OFF.
- Voucher: código gratuito por assessoria/equipe, com limite de usos.
