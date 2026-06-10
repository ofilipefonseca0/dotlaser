dot. laser MVP v6.5

Correção do erro: column events_1.code_prefix does not exist.

Passos:
1. No Supabase, rode schema-v65.sql no SQL Editor.
2. Aguarde 10 a 20 segundos e recarregue o painel.
3. Substitua no GitHub pelo menos o painel.html e o schema-v65.sql.

O painel.html foi ajustado para não depender mais do relacionamento aninhado events(name,code_prefix), evitando o erro events_1.code_prefix.
