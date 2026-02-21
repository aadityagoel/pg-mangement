import { Router } from 'express';

export const apiRouter = Router();

apiRouter.get('/', (_req, res) => {
  res.json({
    message: 'PG Management API v1',
    modules: [
      'auth',
      'users',
      'properties',
      'tenants',
      'rent',
      'payments',
      'complaints',
      'staff',
      'reports',
      'notifications'
    ]
  });
});
