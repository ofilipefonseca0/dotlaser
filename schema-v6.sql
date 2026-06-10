-- DOT. LASER - atualização v6
-- Rode este script no SQL Editor do Supabase antes de subir o index.html v6.

alter table public.events
add column if not exists code_prefix text not null default 'DOT';

update public.events
set code_prefix = 'SELF'
where slug = 'evento-teste' and (code_prefix is null or code_prefix = 'DOT');

alter table public.athletes
add column if not exists engraving_type text not null default 'name_time',
add column if not exists custom_text text;

-- Garante que os tipos usados no front fiquem padronizados.
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'athletes_engraving_type_check'
  ) then
    alter table public.athletes
    add constraint athletes_engraving_type_check
    check (engraving_type in ('name_time','custom_text'));
  end if;
end $$;
