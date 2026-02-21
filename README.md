# PG Management App (Full-Stack Blueprint)

A production-ready blueprint for a **PG (Paying Guest) Management** platform with three roles:
- **Owner (Admin)**
- **Manager**
- **Tenant/User**

This repository provides:
- Modular **Node.js + Express + PostgreSQL** backend structure
- **React** frontend architecture with role-based dashboards
- Database schema for PG operations, tenants, rent, staff, complaints, and analytics
- Payment integration approach (Stripe + Razorpay + UPI)
- Deployment and scalability guidance

## Tech Stack

- **Frontend:** React + Vite + TypeScript + Tailwind (mobile-first, dark mode ready)
- **Backend:** Node.js + Express + TypeScript style modular architecture
- **Database:** PostgreSQL
- **Auth:** JWT + refresh tokens, OTP/email login support
- **Payments:** Razorpay/Stripe checkout + UPI QR workflow
- **Infra:** Docker + AWS (ECS/RDS/S3/CloudFront)

## Key Features

- Role-based authentication & configurable manager permissions
- Multi-PG management under one owner account
- PG/Room/Bed inventory and occupancy analytics
- Tenant lifecycle (check-in to move-out), rent history, deposit tracking
- Auto rent generation, reminders, late fee handling, and receipt PDFs
- Complaint management with status lifecycle and staff assignment
- Staff scheduling, attendance, and cleaning tracking
- Reports: revenue, occupancy, pending payments, expenses
- Notifications via email/SMS/WhatsApp
- Exports (CSV/Excel), backups, activity logs, API rate limiting

## Repository Layout

```txt
backend/
  src/
    config/
    middleware/
    modules/
frontend/
  src/
    app/
    components/
    features/
docs/
  database-schema.sql
  api-structure.md
  frontend-wireframe.md
  deployment-guide.md
  scalability-roadmap.md
```

## Quick Start (Scaffold)

1. Implement environment variables in backend/frontend.
2. Run PostgreSQL and execute `docs/database-schema.sql`.
3. Build backend modules and connect REST routes.
4. Build UI pages per wireframe (`docs/frontend-wireframe.md`).
5. Integrate payment gateways and webhooks.

> This is an architecture-ready starter and documentation package intended for rapid production build-out.
