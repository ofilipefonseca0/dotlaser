-- DOT. LASER - MVP Supabase schema
-- Execute este arquivo no Supabase > SQL Editor > New query > Run

create extension if not exists "pgcrypto";

create table if not exists public.events (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  name text not null,
  city text,
  event_date date,
  base_price numeric(10,2) not null default 29.90,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  order_code text unique not null,
  event_id uuid references public.events(id) on delete set null,
  customer_name text,
  customer_phone text,
  customer_email text,
  coupon_code text,
  team_token text,
  subtotal numeric(10,2) not null default 0,
  discount numeric(10,2) not null default 0,
  total numeric(10,2) not null default 0,
  payment_status text not null default 'pending' check (payment_status in ('pending','paid','free','cancelled')),
  engraving_status text not null default 'pending' check (engraving_status in ('pending','partial','completed')),
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.athletes (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  athlete_index integer not null default 1,
  medal_name text not null,
  race_time text not null,
  engraving_text text generated always as (medal_name || ' | ' || race_time) stored,
  engraved boolean not null default false,
  engraved_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.coupons (
  id uuid primary key default gen_random_uuid(),
  code text unique not null,
  description text,
  discount_type text not null check (discount_type in ('percent','fixed','free')),
  discount_value numeric(10,2) not null default 0,
  max_uses integer,
  used_count integer not null default 0,
  is_active boolean not null default true,
  expires_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.team_tokens (
  id uuid primary key default gen_random_uuid(),
  token text unique not null,
  team_name text not null,
  max_uses integer not null default 1,
  used_count integer not null default 0,
  is_active boolean not null default true,
  expires_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.engraving_logs (
  id uuid primary key default gen_random_uuid(),
  order_id uuid references public.orders(id) on delete cascade,
  athlete_id uuid references public.athletes(id) on delete cascade,
  operator_name text,
  action text not null default 'engraved',
  created_at timestamptz not null default now()
);

-- Dados iniciais para teste
insert into public.events (slug, name, city, event_date, base_price)
values ('evento-teste', 'Evento Teste dot. laser', 'Natal/RN', '2026-10-24', 29.90)
on conflict (slug) do nothing;

insert into public.coupons (code, description, discount_type, discount_value, max_uses)
values
  ('DOT10', '10% de desconto', 'percent', 10, 100),
  ('PULSE15', '15% de desconto', 'percent', 15, 100),
  ('VIP100', 'Gravação gratuita', 'free', 0, 10)
on conflict (code) do nothing;

insert into public.team_tokens (token, team_name, max_uses)
values
  ('PULSE-2026-001', 'Pulse Run Club', 50),
  ('ASSESSORIA-DOT', 'Assessoria parceira dot.', 100),
  ('EQUIPE-GRATIS', 'Equipe Teste', 20)
on conflict (token) do nothing;

-- Habilitar RLS
alter table public.events enable row level security;
alter table public.orders enable row level security;
alter table public.athletes enable row level security;
alter table public.coupons enable row level security;
alter table public.team_tokens enable row level security;
alter table public.engraving_logs enable row level security;

-- Políticas simples para MVP. Depois podemos endurecer com login de operador.
drop policy if exists "Public can read active events" on public.events;
create policy "Public can read active events" on public.events for select using (is_active = true);

drop policy if exists "Public can create orders" on public.orders;
create policy "Public can create orders" on public.orders for insert with check (true);

drop policy if exists "Public can read own-ish orders MVP" on public.orders;
create policy "Public can read own-ish orders MVP" on public.orders for select using (true);

drop policy if exists "Public can update orders MVP" on public.orders;
create policy "Public can update orders MVP" on public.orders for update using (true) with check (true);

drop policy if exists "Public can create athletes" on public.athletes;
create policy "Public can create athletes" on public.athletes for insert with check (true);

drop policy if exists "Public can read athletes MVP" on public.athletes;
create policy "Public can read athletes MVP" on public.athletes for select using (true);

drop policy if exists "Public can update athletes MVP" on public.athletes;
create policy "Public can update athletes MVP" on public.athletes for update using (true) with check (true);

drop policy if exists "Public can read coupons MVP" on public.coupons;
create policy "Public can read coupons MVP" on public.coupons for select using (is_active = true);

drop policy if exists "Public can read tokens MVP" on public.team_tokens;
create policy "Public can read tokens MVP" on public.team_tokens for select using (is_active = true);

drop policy if exists "Public can create logs MVP" on public.engraving_logs;
create policy "Public can create logs MVP" on public.engraving_logs for insert with check (true);

drop policy if exists "Public can read logs MVP" on public.engraving_logs;
create policy "Public can read logs MVP" on public.engraving_logs for select using (true);
