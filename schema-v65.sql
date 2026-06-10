
-- dot. laser MVP v6.5 - correção robusta para code_prefix + cache Supabase

alter table if exists public.events
  add column if not exists code_prefix text;

update public.events
set code_prefix = coalesce(nullif(code_prefix,''), 'DOT')
where code_prefix is null or code_prefix = '';

alter table if exists public.events
  alter column code_prefix set default 'DOT';

-- Campos usados pelo admin/eventos
alter table if exists public.events
  add column if not exists slug text,
  add column if not exists base_price numeric(10,2) default 29.90,
  add column if not exists city text,
  add column if not exists event_date date,
  add column if not exists is_active boolean default true,
  add column if not exists updated_at timestamptz default now();

-- Garante slug em eventos antigos
update public.events
set slug = lower(regexp_replace(regexp_replace(name, '[^a-zA-Z0-9]+', '-', 'g'), '(^-|-$)', '', 'g'))
where slug is null or slug = '';

-- Campos usados pelos pedidos/atletas
alter table if exists public.orders
  add column if not exists event_id uuid references public.events(id),
  add column if not exists order_code text,
  add column if not exists customer_name text,
  add column if not exists customer_phone text,
  add column if not exists customer_email text,
  add column if not exists coupon_code text,
  add column if not exists team_token text,
  add column if not exists subtotal numeric(10,2) default 0,
  add column if not exists discount numeric(10,2) default 0,
  add column if not exists total numeric(10,2) default 0,
  add column if not exists payment_status text default 'pending',
  add column if not exists engraving_status text default 'pending',
  add column if not exists updated_at timestamptz default now();

alter table if exists public.athletes
  add column if not exists athlete_index integer default 1,
  add column if not exists medal_name text,
  add column if not exists race_time text,
  add column if not exists engraved boolean default false,
  add column if not exists engraved_at timestamptz;

-- Recarrega cache do PostgREST/Supabase para novas colunas aparecerem imediatamente
notify pgrst, 'reload schema';
