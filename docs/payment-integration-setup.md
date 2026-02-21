# Payment Integration Setup

## Supported Methods
- UPI (direct QR + intent)
- Credit/Debit Card
- Net Banking
- Wallets (via provider capability)

## Razorpay Flow
1. Backend creates order: `POST /payments/create-order`.
2. Frontend opens Razorpay checkout.
3. On success, frontend sends payment IDs/signature.
4. Backend verifies signature + records transaction.
5. Razorpay webhook confirms eventual status.
6. System generates receipt PDF and sends email/WhatsApp.

## Stripe Flow
1. Backend creates Checkout Session/PaymentIntent.
2. Frontend redirects to Stripe checkout.
3. Webhook (`payment_intent.succeeded`) updates invoice/payment status.
4. Receipt generated and attached to tenant timeline.

## UPI QR Direct Transfer
1. Owner uploads UPI QR to property profile.
2. Tenant scans and pays in UPI app.
3. Tenant uploads txn ref or provider callback validates payment.
4. Manager/Owner verifies pending records if needed.

## Security Notes
- Verify all webhooks with provider secret.
- Never trust client payment status directly.
- Store minimum payment metadata, tokenize sensitive data.
- Enable idempotency keys for create-order endpoints.
