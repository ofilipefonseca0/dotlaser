-- DOT. LASER - Segurança do painel com Supabase Auth
-- Execute este arquivo no Supabase > SQL Editor > New query > Run
-- Ele substitui as políticas abertas do MVP por políticas mais seguras.

alter table public.events enable row level security;
alter table public.orders enable row level security;
alter table public.athletes enable row level security;
alter table public.coupons enable row level security;
alter table public.team_tokens enable row level security;
alter table public.engraving_logs enable row level security;

-- Remover políticas antigas do MVP
DROP POLICY IF EXISTS "Public can read active events" ON public.events;
DROP POLICY IF EXISTS "Public can create orders" ON public.orders;
DROP POLICY IF EXISTS "Public can read own-ish orders MVP" ON public.orders;
DROP POLICY IF EXISTS "Public can update orders MVP" ON public.orders;
DROP POLICY IF EXISTS "Public can create athletes" ON public.athletes;
DROP POLICY IF EXISTS "Public can read athletes MVP" ON public.athletes;
DROP POLICY IF EXISTS "Public can update athletes MVP" ON public.athletes;
DROP POLICY IF EXISTS "Public can read coupons MVP" ON public.coupons;
DROP POLICY IF EXISTS "Public can read tokens MVP" ON public.team_tokens;
DROP POLICY IF EXISTS "Public can create logs MVP" ON public.engraving_logs;
DROP POLICY IF EXISTS "Public can read logs MVP" ON public.engraving_logs;

-- Eventos, cupons e tokens precisam ser lidos pela página pública do atleta
CREATE POLICY "Public can read active events" ON public.events
FOR SELECT USING (is_active = true);

CREATE POLICY "Public can read active coupons" ON public.coupons
FOR SELECT USING (is_active = true);

CREATE POLICY "Public can read active team tokens" ON public.team_tokens
FOR SELECT USING (is_active = true);

-- Página pública pode criar pedidos e atletas, mas não listar/alterar pedidos existentes
CREATE POLICY "Public can create orders" ON public.orders
FOR INSERT WITH CHECK (true);

CREATE POLICY "Public can create athletes" ON public.athletes
FOR INSERT WITH CHECK (true);

-- Operadores autenticados podem consultar e operar pedidos/atletas
CREATE POLICY "Authenticated can read orders" ON public.orders
FOR SELECT TO authenticated USING (true);

CREATE POLICY "Authenticated can update orders" ON public.orders
FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Authenticated can read athletes" ON public.athletes
FOR SELECT TO authenticated USING (true);

CREATE POLICY "Authenticated can update athletes" ON public.athletes
FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Authenticated can create logs" ON public.engraving_logs
FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "Authenticated can read logs" ON public.engraving_logs
FOR SELECT TO authenticated USING (true);
