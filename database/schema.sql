-- Supabase marketplace schema for VOILANOVA

create table if not exists profiles (
  id uuid primary key references auth.users(id),
  email text not null,
  full_name text not null,
  role text not null check (role in ('admin', 'seller', 'customer')),
  created_at timestamp with time zone default timezone('utc', now()) not null
);

create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text not null,
  price numeric not null,
  compare_at_price numeric,
  stock int not null default 0,
  category text not null,
  vendor_id uuid not null references profiles(id),
  primary_image_url text not null,
  secondary_images_urls text[] default array[]::text[],
  is_featured boolean not null default false,
  is_deal boolean not null default false,
  approval_status text not null default 'pending' check (approval_status in ('pending', 'approved', 'rejected'))
);

create table if not exists orders (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid not null references profiles(id),
  items_json jsonb not null,
  total_price numeric not null,
  net_earnings numeric not null,
  platform_fee numeric not null,
  payment_method text not null,
  status text not null default 'processing' check (status in ('processing', 'shipped', 'delivered', 'cancelled')),
  shipping_address_json jsonb not null,
  created_at timestamp with time zone default timezone('utc', now()) not null
);

create table if not exists payout_requests (
  id uuid primary key default gen_random_uuid(),
  seller_id uuid not null references profiles(id),
  amount numeric not null,
  method text not null,
  status text not null default 'pending' check (status in ('pending', 'paid')),
  transaction_code text not null,
  created_at timestamp with time zone default timezone('utc', now()) not null
);

create index if not exists idx_products_vendor_id on products(vendor_id);
create index if not exists idx_orders_customer_id on orders(customer_id);
create index if not exists idx_payout_requests_seller_id on payout_requests(seller_id);
