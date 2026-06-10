dot. laser MVP v6.3 - Hotfix cadastro e admin

1) No Supabase, rode o arquivo schema-v63.sql no SQL Editor.

2) No GitHub, substitua/suba estes arquivos:
- index.html
- painel.html
- admin.html
- login.html
- schema-v63.sql
- README.txt

Correções desta versão:
- Corrige "Erro ao salvar atletas" removendo dependência dos campos extras no insert.
- Mantém tempo de prova como opcional.
- Corrige políticas de leitura/criação de eventos para usuários logados.
- Adiciona botão "Voltar" no painel de eventos.
- Melhora mensagem de erro na criação de evento.
- Evita conflito de slug quando o evento já existe.

Páginas:
- index.html = cadastro do atleta
- painel.html = painel operacional
- admin.html = criação/gestão de eventos
- login.html = login dos operadores/admin
