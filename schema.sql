create table public.jobs (
  id uuid not null default gen_random_uuid (),
  company text not null,
  position text not null,
  status text not null,
  priority text not null,
  date_applied date null,
  created_at timestamp without time zone null default now(),
  date_of_interview date null,
  date_accepted date null,
  date_rejected date null,
  constraint jobs_pkey primary key (id)
);

create table public.user_jobs (
  id uuid not null default gen_random_uuid (),
  user_id uuid not null references auth.users (id) on delete cascade,
  job_id uuid not null references public.jobs (id) on delete cascade,
  constraint user_jobs_pkey primary key (id),
  constraint user_jobs_user_id_job_id_key unique (user_id, job_id)
);

create table public.activities (
  id uuid not null default gen_random_uuid (),
  job_id uuid null references public.jobs (id) on delete cascade,
  type text not null,
  description text not null,
  created_at timestamp without time zone null default now(),
  constraint activities_pkey primary key (id)
);

create table public.resumes (
  id uuid not null default gen_random_uuid (),
  created_at timestamp with time zone not null default timezone ('utc'::text, now()),
  title text not null,
  content jsonb not null,
  user_id uuid not null references auth.users (id),
  constraint resumes_pkey primary key (id)
);

alter table public.jobs enable row level security;
alter table public.user_jobs enable row level security;
alter table public.activities enable row level security;
alter table public.resumes enable row level security;

create policy "Users can manage their own resumes" on public.resumes
  for all using (auth.uid() = user_id);

create policy "Users can view their own linked jobs" on public.jobs
  for select using (
    exists (
      select 1 from public.user_jobs 
      where user_jobs.job_id = jobs.id and user_jobs.user_id = auth.uid()
    )
  );

create policy "Users can manage their own job links" on public.user_jobs
  for all using (auth.uid() = user_id);

create policy "Users can view activities for their jobs" on public.activities
  for all using (
    exists (
      select 1 from public.user_jobs 
      where user_jobs.job_id = activities.job_id and user_jobs.user_id = auth.uid()
    )
  );