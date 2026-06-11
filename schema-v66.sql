-- DOT. LASER - v6.6 hotfix admin
-- Corrige/cria campos de eventos e garante políticas para criação via painel logado.

create extension if not exists "pgcrypto";

alter table if exists public.events
  add column if not exists slug text,
  add column if not exists code_prefix text default 'DOT',
  add column if not exists base_price numeric(10,2) default 29.90,
  add column if not exists city text,
  add column if not exists event_date date,
  add column if not exists is_active boolean default true,
  add column if not exists updated_at timestamptz default now();

update public.events
set code_prefix = coalesce(nullif(code_prefix,''), 'DOT')
where code_prefix is null or code_prefix = '';

update public.events
set slug = lower(regexp_replace(regexp_replace(coalesce(name,'evento'), '[^a-zA-Z0-9]+', '-', 'g'), '(^-|-$)', '', 'g'))
where slug is null or slug = '';

alter table public.events enable row level security;

drop policy if exists "Public can read active events" on public.events;
create policy "Public can read active events" on public.events
for select to anon using (coalesce(is_active,true) = true);

drop policy if exists "Authenticated can read all events" on public.events;
create policy "Authenticated can read all events" on public.events
for select to authenticated using (true);

drop policy if exists "Authenticated can create events" on public.events;
create policy "Authenticated can create events" on public.events
for insert to authenticated with check (true);

drop policy if exists "Authenticated can update events" on public.events;
create policy "Authenticated can update events" on public.events
for update to authenticated using (true) with check (true);

notify pgrst, 'reload schema';
