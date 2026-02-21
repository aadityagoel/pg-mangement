import { useMemo, useState } from 'react';

type Role = 'OWNER' | 'MANAGER' | 'TENANT';

const cardsByRole: Record<Role, string[]> = {
  OWNER: ['Total PGs', 'Total Tenants', 'Monthly Revenue', 'Pending Payments', 'Complaints'],
  MANAGER: ['Assigned Properties', 'Today Check-ins', 'Open Complaints', 'Staff Attendance'],
  TENANT: ['Current Rent', 'Payment History', 'Open Complaints', 'Agreement Documents']
};

export default function App() {
  const [role, setRole] = useState<Role>('OWNER');
  const [darkMode, setDarkMode] = useState(false);

  const cards = useMemo(() => cardsByRole[role], [role]);

  return (
    <main style={{ padding: 20, fontFamily: 'Inter, sans-serif', background: darkMode ? '#0b1220' : '#f8fafc', color: darkMode ? '#e2e8f0' : '#0f172a', minHeight: '100vh' }}>
      <h1>PG Management Dashboard</h1>
      <div style={{ display: 'flex', gap: 12, marginBottom: 16 }}>
        <select value={role} onChange={(e) => setRole(e.target.value as Role)}>
          <option value="OWNER">Owner</option>
          <option value="MANAGER">Manager</option>
          <option value="TENANT">Tenant</option>
        </select>
        <button onClick={() => setDarkMode((v) => !v)}>{darkMode ? 'Light' : 'Dark'} Mode</button>
      </div>
      <section style={{ display: 'grid', gap: 12, gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))' }}>
        {cards.map((item) => (
          <article key={item} style={{ background: darkMode ? '#1e293b' : '#fff', borderRadius: 12, padding: 16, boxShadow: '0 2px 8px rgba(15,23,42,0.08)' }}>
            <h3 style={{ margin: 0 }}>{item}</h3>
            <p style={{ opacity: 0.75, marginBottom: 0 }}>KPI widget with chart/metric</p>
          </article>
        ))}
      </section>
    </main>
  );
}
