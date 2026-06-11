-- DOT. LASER - v7.4
-- Área administrativa de cupons e vouchers.

create extension if not exists "pgcrypto";

create table if not exists public.coupons (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  discount_type text not null default 'percent' check (discount_type in ('percent','fixed')),
  discount_value numeric(10,2) not null default 0,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.vouchers (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  team_name text,
  uses_limit integer not null default 1,
  uses_count integer not null default 0,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.coupons
  add column if not exists active boolean default true,
  add column if not exists created_at timestamptz default now();

alter table public.vouchers
  add column if not exists team_name text,
  add column if not exists uses_limit integer default 1,
  add column if not exists uses_count integer default 0,
  add column if not exists active boolean default true,
  add column if not exists created_at timestamptz default now();

-- Normaliza códigos já existentes.
update public.coupons set code = upper(trim(code)) where code is not null;
update public.vouchers set code = upper(trim(code)) where code is not null;

alter table public.coupons enable row level security;
alter table public.vouchers enable row level security;

-- Limpa policies antigas para evitar conflito.
do $$
declare p record;
begin
  for p in select policyname from pg_policies where schemaname='public' and tablename='coupons'
  loop execute format('drop policy if exists %I on public.coupons', p.policyname); end loop;
  for p in select policyname from pg_policies where schemaname='public' and tablename='vouchers'
  loop execute format('drop policy if exists %I on public.vouchers', p.policyname); end loop;
end $$;

-- Página pública precisa ler apenas ativos para validar cupom/voucher.
create policy "coupons_public_read_active"
on public.coupons for select to anon
using (active = true);

create policy "vouchers_public_read_active"
on public.vouchers for select to anon
using (active = true and uses_count < uses_limit);

-- Painel admin usa usuário autenticado. A interface restringe a admin.
create policy "coupons_auth_read"
on public.coupons for select to authenticated
using (true);

create policy "coupons_auth_insert"
on public.coupons for insert to authenticated
with check (true);

create policy "coupons_auth_update"
on public.coupons for update to authenticated
using (true) with check (true);

create policy "vouchers_auth_read"
on public.vouchers for select to authenticated
using (true);

create policy "vouchers_auth_insert"
on public.vouchers for insert to authenticated
with check (true);

create policy "vouchers_auth_update"
on public.vouchers for update to authenticated
using (true) with check (true);

notify pgrst, 'reload schema';
