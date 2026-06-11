DOT. LASER - MVP v7

O que mudou:
1. Usuário administrador e usuário operador.
2. Operador não vê valores/faturamento e não acessa o painel de eventos.
3. Administrador continua com acesso completo.
4. Administrador pode arquivar/desarquivar pedidos no painel.
5. Pedidos arquivados ficam ocultos por padrão.
6. Placeholder alterado para "Ex.: JOÃO".
7. Tempo com hora sem zero na frente. Ex.: 12233 vira 1:22:33.

COMO ATUALIZAR:

1. Supabase
- Abra o arquivo schema-v7.sql.
- Vá em SQL Editor > New Query.
- Cole tudo e clique em Run.

2. Definir usuário administrador
Depois de rodar o schema-v7.sql, execute este comando trocando o e-mail pelo seu usuário de login:

insert into public.profiles (id, full_name, role)
select id, email, 'admin'
from auth.users
where email = 'SEU_EMAIL_AQUI'
on conflict (id) do update set role='admin', full_name=excluded.full_name;

3. Definir usuário operador
Para cada operador, use:

insert into public.profiles (id, full_name, role)
select id, email, 'operator'
from auth.users
where email = 'EMAIL_DO_OPERADOR_AQUI'
on conflict (id) do update set role='operator', full_name=excluded.full_name;

4. GitHub
Substitua/suba estes arquivos:
- index.html
- painel.html
- admin.html
- login.html
- schema-v7.sql
- README.txt

5. Testes recomendados
- Entrar com usuário admin e verificar se aparece o botão Eventos.
- Entrar com usuário operador e verificar que o botão Eventos não aparece.
- Como operador, verificar que não aparecem valores dos pedidos.
- Como admin, arquivar um pedido e confirmar que ele some da lista padrão.
- Marcar "Mostrar arquivados" como admin e confirmar que o pedido aparece novamente.
