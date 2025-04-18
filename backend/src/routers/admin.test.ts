import { app } from "../app";
import request from 'supertest';
import { sign } from "jsonwebtoken";
import config from "config";

// Mocks
jest.mock('../middlewares/enforce-auth', () => ({
  enforceAuth: (req: any, res: any, next: any) => {
    const auth = req.headers.authorization;
    if (!auth) return res.status(401).send('Unauthorized');
    return next();
  },
  enforceRoleAdmin: (req: any, res: any, next: any) => next()
}));

jest.mock('../controllers/admin/controller', () => ({
  getVacations: (req: any, res: any) => res.status(200).json([{ id: 1, name: 'Mock Vacation' }]),
  createVacation: (req: any, res: any) => res.status(201).json({ id: 99, name: req.body.name }),
  deleteVacation: (req: any, res: any) => res.status(200).json({ message: 'Deleted' }),
  editVacation: (req: any, res: any) => res.status(200).json({}),
  getSingleVacation: (req: any, res: any) => res.status(200).json({})
}));

const jwt = sign({ id: '1230ae30-dc4f-4752-bd84-092956f5c633', role: 'admin' }, config.get<string>('app.jwtSecret'));

describe('Admin Router Tests', () => {
  test('GET /admin/vacations should return 401 without auth', async () => {
    const res = await request(app).get('/admin/vacations');
    expect(res.statusCode).toBe(401);
  });

  test('GET /admin/vacations should return 200 with auth', async () => {
    const res = await request(app).get('/admin/vacations').set('Authorization', `Bearer ${jwt}`);
    expect(res.statusCode).toBe(200);
  });

  test('POST /admin/new should return 401 without auth', async () => {
    const res = await request(app).post('/admin/new').send({
        destination: 'Holiday',
        description: 'Relaxing trip',
        startDate: '2025-05-01',
        endDate: '2025-05-10',
        price: 1500
      });
    expect(res.statusCode).toBe(401);
  });

  test('POST /admin/new should return 201 with auth', async () => {
    const res = await request(app)
      .post('/admin/new')
      .set('Authorization', `Bearer ${jwt}`)
      .send({
        destination: 'Holiday',
        description: 'Relaxing trip',
        startDate: '2025-05-01',
        endDate: '2025-05-10',
        price: 1500
      });
    expect(res.statusCode).toBe(201);
  });

  test('DELETE /admin/1 should return 401 without auth', async () => {
    const res = await request(app).delete('/admin/1');
    expect(res.statusCode).toBe(401);
  });

  test('DELETE /admin/1 should return 200 with auth', async () => {
    const res = await request(app)
      .delete('/admin/123e4567-e89b-12d3-a456-426614174000') // <-- valid UUID
      .set('Authorization', `Bearer ${jwt}`);
    expect(res.statusCode).toBe(200);
  });  
});
