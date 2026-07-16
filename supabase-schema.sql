-- ============================================================
-- Schema Supabase per "Campus Orizzonti Armonici 2026"
-- App unificata: mensa + prenotazione aule
--
-- Uso:
-- 1. Supabase > SQL Editor > New query
-- 2. Incolla tutto questo file
-- 3. Run
-- ============================================================

create table if not exists app_state (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create or replace function set_app_state_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists app_state_set_updated_at on app_state;

create trigger app_state_set_updated_at
before update on app_state
for each row
execute function set_app_state_updated_at();

alter table app_state enable row level security;

drop policy if exists "app_state_select" on app_state;
drop policy if exists "app_state_insert" on app_state;
drop policy if exists "app_state_update" on app_state;
drop policy if exists "app_state_delete" on app_state;

-- Nota: queste policy sono semplici e adatte a una app con link condiviso.
-- La protezione admin/operatore resta lato app con password.
-- Per un uso pubblico esteso conviene passare a Supabase Auth e RLS per ruolo.
create policy "app_state_select" on app_state for select using (true);
create policy "app_state_insert" on app_state for insert with check (true);
create policy "app_state_update" on app_state for update using (true);
create policy "app_state_delete" on app_state for delete using (true);

do $$
begin
  alter publication supabase_realtime add table app_state;
exception
  when duplicate_object then null;
end $$;
