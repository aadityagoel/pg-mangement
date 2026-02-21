# REST API Structure (v1)

Base URL: `/api/v1`

## Authentication
- `POST /auth/signup` (email/password or mobile)
- `POST /auth/login`
- `POST /auth/otp/send`
- `POST /auth/otp/verify`
- `POST /auth/refresh`
- `POST /auth/logout`

## User & Role Management
- `GET /users/me`
- `PATCH /users/me`
- `POST /owners/managers` (assign manager)
- `DELETE /owners/managers/:managerId` (remove manager)
- `PUT /owners/managers/:managerId/permissions`

## Property Management
- `POST /properties`
- `GET /properties`
- `GET /properties/:id`
- `PATCH /properties/:id`
- `DELETE /properties/:id`
- `POST /properties/:id/rooms`
- `POST /rooms/:roomId/beds`
- `GET /properties/:id/occupancy`

## Tenant Management
- `POST /tenants`
- `GET /tenants`
- `GET /tenants/:id`
- `PATCH /tenants/:id`
- `POST /tenants/:id/move-out`
- `GET /tenants/:id/rent-history`

## Rent & Payments
- `POST /rent/invoices/generate-monthly`
- `GET /rent/invoices`
- `GET /rent/invoices/:id`
- `POST /payments/create-order` (Stripe/Razorpay)
- `POST /payments/webhook/stripe`
- `POST /payments/webhook/razorpay`
- `POST /payments/:id/confirm`
- `GET /payments/transactions`
- `GET /receipts/:paymentId/pdf`

## Complaints
- `POST /complaints`
- `GET /complaints`
- `PATCH /complaints/:id/status`
- `PATCH /complaints/:id/assign-staff`
- `PATCH /complaints/:id/resolve`

## Staff & Cleaning
- `POST /staff`
- `GET /staff`
- `DELETE /staff/:id`
- `POST /staff/attendance`
- `POST /cleaning/schedules`
- `PATCH /cleaning/tasks/:id/complete`

## Reports & Export
- `GET /reports/dashboard-summary`
- `GET /reports/revenue?month=YYYY-MM`
- `GET /reports/occupancy`
- `GET /reports/expenses`
- `GET /exports/tenants.csv`
- `GET /exports/payments.xlsx`

## Notifications
- `POST /notifications/send`
- `GET /notifications`
- `PATCH /notifications/:id/read`

## Security Patterns
- JWT auth headers: `Authorization: Bearer <token>`
- RBAC middleware by role + manager permission map
- Rate-limit auth/payment endpoints
- Signed URL uploads for ID proof and complaint images
