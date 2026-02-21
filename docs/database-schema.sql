-- PG Management database schema (PostgreSQL)

CREATE TYPE user_role AS ENUM ('OWNER', 'MANAGER', 'TENANT');
CREATE TYPE bed_status AS ENUM ('VACANT', 'OCCUPIED');
CREATE TYPE complaint_status AS ENUM ('OPEN', 'IN_PROGRESS', 'RESOLVED');
CREATE TYPE payment_status AS ENUM ('PENDING', 'SUCCESS', 'FAILED', 'REFUNDED');
CREATE TYPE payment_mode AS ENUM ('UPI', 'CARD', 'NET_BANKING', 'CASH');

CREATE TABLE users (
  id UUID PRIMARY KEY,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(120) UNIQUE,
  mobile VARCHAR(20) UNIQUE,
  password_hash TEXT,
  role user_role NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE manager_permissions (
  id UUID PRIMARY KEY,
  manager_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  permission_key VARCHAR(80) NOT NULL,
  is_allowed BOOLEAN NOT NULL DEFAULT TRUE,
  UNIQUE(manager_id, permission_key)
);

CREATE TABLE properties (
  id UUID PRIMARY KEY,
  owner_id UUID NOT NULL REFERENCES users(id),
  name VARCHAR(150) NOT NULL,
  address TEXT NOT NULL,
  city VARCHAR(80),
  state VARCHAR(80),
  pincode VARCHAR(12),
  upi_qr_url TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE rooms (
  id UUID PRIMARY KEY,
  property_id UUID NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
  room_number VARCHAR(20) NOT NULL,
  floor_no INT,
  monthly_rent NUMERIC(10,2) NOT NULL,
  UNIQUE(property_id, room_number)
);

CREATE TABLE beds (
  id UUID PRIMARY KEY,
  room_id UUID NOT NULL REFERENCES rooms(id) ON DELETE CASCADE,
  bed_label VARCHAR(20) NOT NULL,
  status bed_status NOT NULL DEFAULT 'VACANT',
  UNIQUE(room_id, bed_label)
);

CREATE TABLE tenants (
  id UUID PRIMARY KEY,
  user_id UUID UNIQUE REFERENCES users(id),
  property_id UUID NOT NULL REFERENCES properties(id),
  room_id UUID NOT NULL REFERENCES rooms(id),
  bed_id UUID NOT NULL REFERENCES beds(id),
  id_proof_url TEXT,
  check_in_date DATE NOT NULL,
  check_out_date DATE,
  security_deposit NUMERIC(10,2) DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE rent_invoices (
  id UUID PRIMARY KEY,
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  due_month DATE NOT NULL,
  base_rent NUMERIC(10,2) NOT NULL,
  late_fee NUMERIC(10,2) DEFAULT 0,
  total_due NUMERIC(10,2) NOT NULL,
  due_date DATE NOT NULL,
  status payment_status NOT NULL DEFAULT 'PENDING',
  generated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE(tenant_id, due_month)
);

CREATE TABLE payments (
  id UUID PRIMARY KEY,
  invoice_id UUID NOT NULL REFERENCES rent_invoices(id),
  amount NUMERIC(10,2) NOT NULL,
  payment_mode payment_mode NOT NULL,
  provider VARCHAR(40),
  provider_txn_id VARCHAR(120),
  status payment_status NOT NULL,
  paid_at TIMESTAMP,
  raw_payload JSONB
);

CREATE TABLE receipts (
  id UUID PRIMARY KEY,
  payment_id UUID UNIQUE NOT NULL REFERENCES payments(id),
  receipt_number VARCHAR(40) UNIQUE NOT NULL,
  pdf_url TEXT,
  emailed BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE complaints (
  id UUID PRIMARY KEY,
  tenant_id UUID NOT NULL REFERENCES tenants(id),
  category VARCHAR(50) NOT NULL,
  description TEXT NOT NULL,
  image_url TEXT,
  status complaint_status NOT NULL DEFAULT 'OPEN',
  assigned_staff_id UUID,
  resolution_notes TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE staff (
  id UUID PRIMARY KEY,
  property_id UUID NOT NULL REFERENCES properties(id),
  full_name VARCHAR(120) NOT NULL,
  role VARCHAR(40) NOT NULL,
  phone VARCHAR(20),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE staff_attendance (
  id UUID PRIMARY KEY,
  staff_id UUID NOT NULL REFERENCES staff(id) ON DELETE CASCADE,
  attendance_date DATE NOT NULL,
  is_present BOOLEAN NOT NULL,
  UNIQUE(staff_id, attendance_date)
);

CREATE TABLE cleaning_tasks (
  id UUID PRIMARY KEY,
  property_id UUID NOT NULL REFERENCES properties(id),
  room_id UUID NOT NULL REFERENCES rooms(id),
  staff_id UUID REFERENCES staff(id),
  schedule_date DATE NOT NULL,
  completed BOOLEAN NOT NULL DEFAULT FALSE,
  completed_at TIMESTAMP
);

CREATE TABLE expenses (
  id UUID PRIMARY KEY,
  property_id UUID NOT NULL REFERENCES properties(id),
  category VARCHAR(50) NOT NULL,
  amount NUMERIC(10,2) NOT NULL,
  note TEXT,
  expense_date DATE NOT NULL
);

CREATE TABLE notifications (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES users(id),
  channel VARCHAR(20) NOT NULL,
  title VARCHAR(140) NOT NULL,
  message TEXT NOT NULL,
  is_read BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE activity_logs (
  id UUID PRIMARY KEY,
  actor_user_id UUID REFERENCES users(id),
  action VARCHAR(120) NOT NULL,
  entity_type VARCHAR(50),
  entity_id UUID,
  metadata JSONB,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
