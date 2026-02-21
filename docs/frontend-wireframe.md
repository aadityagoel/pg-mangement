# Frontend Wireframe (Mobile-First)

## Shared Layout
- Top bar: PG selector, notifications, profile
- Left drawer / bottom nav: Dashboard, Tenants, Payments, Complaints, Staff, Reports
- Theme switch: Light / Dark mode

## Owner Dashboard
1. KPI cards:
   - Total PGs
   - Total Tenants
   - Occupied vs Vacant Beds
   - Monthly Revenue
   - Pending Payments
2. Charts:
   - Revenue trend (line)
   - Occupancy split (donut)
   - Complaints by status (stacked bar)
3. Quick actions:
   - Add PG
   - Add Tenant
   - Generate Invoices
   - Export Reports

## Manager Dashboard
1. Assigned properties summary
2. Tasks due today (cleaning, check-ins, complaints)
3. Complaint queue with status filters
4. Staff attendance and pending approvals

## Tenant Dashboard
1. Next rent due card + Pay Now CTA
2. Rent history and receipt downloads
3. Complaint submission + status tracker
4. Agreement documents and profile details

## Key Flows
- Auth: OTP login, email login, forgot password
- Tenant onboarding: Add tenant -> assign room/bed -> upload documents -> generate agreement
- Payment flow: Invoice -> checkout -> webhook confirmation -> receipt PDF/email
- Complaint flow: Raise -> assign -> progress -> resolved + notes
