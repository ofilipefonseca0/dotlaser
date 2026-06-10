DOT. LASER - MVP v4 com login no painel

Arquivos:
- index.html: página pública do atleta
- login.html: tela de login dos operadores
- painel.html: painel interno protegido
- schema.sql: estrutura inicial completa do banco
- schema-auth.sql: políticas de segurança para proteger o painel

Como atualizar:
1. Suba index.html, login.html e painel.html para o GitHub.
2. Faça commit. A Vercel deve publicar automaticamente.
3. No Supabase, vá em Authentication > Users > Add user.
4. Crie um usuário de operador com e-mail e senha.
5. No Supabase, vá em SQL Editor, cole o conteúdo de schema-auth.sql e clique em Run.
6. Teste:
   - dotlaser.vercel.app/index.html deve continuar público.
   - dotlaser.vercel.app/painel.html deve redirecionar para login.html.
   - Após login, o painel deve abrir normalmente.

Observação:
A partir dessa versão, o código do pedido usa formato aleatório, exemplo DOT-8F3K2A, para não depender de leitura pública da tabela de pedidos.


V5:
- Gera QR Code na tela de sucesso do atleta.
- Permite baixar o QR Code em PNG.
- Painel dos operadores ganhou botão Ler QR Code usando a câmera.
- Ao ler o QR, o campo de busca é preenchido automaticamente com o código do pedido.
