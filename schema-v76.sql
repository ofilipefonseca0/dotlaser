-- DOT. LASER - v7.6
-- Exclusão definitiva para eventos, cupons e vouchers apenas para administradores.

create or replace function public.is_admin_user(uid uuid)
returns boolean
language sql
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.profiles
    where id = uid
      and lower(coalesce(role, '')) = 'admin'
  );
$$;

grant execute on function public.is_admin_user(uuid) to authenticated;

alter table public.events enable row level security;
alter table public.coupons enable row level security;
alter table public.vouchers enable row level security;

drop policy if exists "events_admin_delete" on public.events;
create policy "events_admin_delete"
on public.events
for delete
to authenticated
using (public.is_admin_user(auth.uid()));

drop policy if exists "coupons_admin_delete" on public.coupons;
create policy "coupons_admin_delete"
on public.coupons
for delete
to authenticated
using (public.is_admin_user(auth.uid()));

drop policy if exists "vouchers_admin_delete" on public.vouchers;
create policy "vouchers_admin_delete"
on public.vouchers
for delete
to authenticated
using (public.is_admin_user(auth.uid()));

notify pgrst, 'reload schema';
