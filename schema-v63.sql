-- DOT. LASER - hotfix v6.3
-- Rode no Supabase > SQL Editor antes de testar a versão v6.3.

create extension if not exists "pgcrypto";

-- Garante que a tabela de eventos tenha todos os campos usados pelo admin.html
alter table public.events
  add column if not exists city text,
  add column if not exists event_date date,
  add column if not exists base_price numeric(10,2) not null default 29.90,
  add column if not exists is_active boolean not null default true,
  add column if not exists code_prefix text not null default 'DOT';

-- Garante que tempo seja opcional no cadastro de atletas
alter table public.athletes
  alter column race_time drop not null;

-- Remove dependência de campos extras antigos da v6 avançada, mantendo compatibilidade se eles existirem.
alter table public.athletes
  add column if not exists engraving_type text not null default 'name_time',
  add column if not exists custom_text text;

-- Políticas necessárias para cadastro público e painel/admin logados.
alter table public.events enable row level security;
alter table public.orders enable row level security;
alter table public.athletes enable row level security;

drop policy if exists "Public can read active events" on public.events;
create policy "Public can read active events" on public.events
for select to anon using (is_active = true);

drop policy if exists "Authenticated can read all events" on public.events;
create policy "Authenticated can read all events" on public.events
for select to authenticated using (true);

drop policy if exists "Authenticated can create events" on public.events;
create policy "Authenticated can create events" on public.events
for insert to authenticated with check (true);

drop policy if exists "Authenticated can update events" on public.events;
create policy "Authenticated can update events" on public.events
for update to authenticated using (true) with check (true);

-- Garante inserção pública do pedido/atleta pela página do atleta.
drop policy if exists "Public can create orders" on public.orders;
create policy "Public can create orders" on public.orders
for insert to anon with check (true);

drop policy if exists "Public can create athletes" on public.athletes;
create policy "Public can create athletes" on public.athletes
for insert to anon with check (true);

-- Garante que operadores logados possam ler/atualizar pedidos e atletas.
drop policy if exists "Authenticated can read orders" on public.orders;
create policy "Authenticated can read orders" on public.orders
for select to authenticated using (true);

drop policy if exists "Authenticated can update orders" on public.orders;
create policy "Authenticated can update orders" on public.orders
for update to authenticated using (true) with check (true);

drop policy if exists "Authenticated can read athletes" on public.athletes;
create policy "Authenticated can read athletes" on public.athletes
for select to authenticated using (true);

drop policy if exists "Authenticated can update athletes" on public.athletes;
create policy "Authenticated can update athletes" on public.athletes
for update to authenticated using (true) with check (true);

-- Compatibilidade com políticas MVP antigas, caso existam.
drop policy if exists "Public can read own-ish orders MVP" on public.orders;
drop policy if exists "Public can read athletes MVP" on public.athletes;
drop policy if exists "Public can update orders MVP" on public.orders;
drop policy if exists "Public can update athletes MVP" on public.athletes;
