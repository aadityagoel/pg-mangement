# Deployment Guide

## 1) Infrastructure
- **Frontend:** Vercel/Netlify or AWS S3 + CloudFront
- **Backend API:** AWS ECS Fargate (or EC2), behind ALB
- **Database:** AWS RDS PostgreSQL (Multi-AZ)
- **Files:** AWS S3 for ID proofs, complaint images, receipts
- **Queue/Jobs:** BullMQ + Redis (rent reminders, report generation)

## 2) Environment Variables
- `JWT_SECRET`, `JWT_REFRESH_SECRET`
- `DATABASE_URL`
- `STRIPE_SECRET_KEY`, `STRIPE_WEBHOOK_SECRET`
- `RAZORPAY_KEY_ID`, `RAZORPAY_KEY_SECRET`, `RAZORPAY_WEBHOOK_SECRET`
- `SMTP_*`, `TWILIO_*`, `WHATSAPP_API_TOKEN`
- `S3_BUCKET`, `AWS_REGION`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`

## 3) CI/CD
- GitHub Actions:
  - lint/test/build backend & frontend
  - docker image build + push
  - deploy to ECS
- Run DB migrations before app rollout.

## 4) Security Hardening
- WAF + rate limits for auth/payment endpoints
- HTTPS everywhere, HSTS headers
- Encrypt secrets in AWS Secrets Manager
- Malware scan uploads and validate MIME types

## 5) Backups & Restore
- Daily RDS snapshots
- Weekly S3 backup lifecycle rule
- Quarterly restore drill into staging
