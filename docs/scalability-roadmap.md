# Future Scalability Suggestions

1. **Domain decomposition**
   - Split modules into microservices: Auth, Billing, Complaint, Notification.
2. **Event-driven architecture**
   - Use Kafka/SQS for rent generation, reminders, webhook processing.
3. **Caching layer**
   - Redis cache for dashboard aggregates and occupancy metrics.
4. **Search & analytics**
   - Add OpenSearch for fast tenant/complaint search.
5. **Data warehouse**
   - Stream transactional data to BigQuery/Redshift for BI dashboards.
6. **Multi-tenant SaaS**
   - Tenant isolation by owner account and row-level security.
7. **Observability**
   - OpenTelemetry traces + Prometheus + Grafana.
8. **Advanced AI add-ons**
   - Predict churn and vacancy risk, smart rent pricing, complaint triage assistant.
