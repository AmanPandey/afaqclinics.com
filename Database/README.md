# Afaq Clinics database

MySQL / MariaDB schema for afaqclinics.com, rebuilt from the website (the original
database was not part of the HTTrack copy of the site). Tested on MariaDB 10.4.

## Files

| File | In git? | What it is |
|------|---------|------------|
| `schema.sql` | yes | All 20 tables: structure only, no data |
| `seed_data.sql` | yes | Public site content extracted from the pages (branches, departments, services, offers with prices, insights, awards, contact settings) |
| `backups/` | **no** | Real exports from the live server (appointments, patients, subscribers). Ignored by git; keep a private copy elsewhere |

## Tables

| Group | Tables |
|-------|--------|
| Admin | `admin_users` |
| Clinic | `branches`, `departments`, `branch_departments`, `services`, `doctors`, `doctor_departments`, `doctor_schedules` |
| Content | `offers`, `insight_categories`, `insights`, `events_awards`, `testimonials`, `banners` |
| Form submissions | `appointments`, `contact_messages`, `international_enquiries`, `enquiry_attachments`, `newsletter_subscribers` |
| Settings | `site_settings` |

## Install

```bash
mysql -u USER -p DB_NAME < schema.sql
mysql -u USER -p --default-character-set=utf8mb4 DB_NAME < seed_data.sql
```

Or in phpMyAdmin: select the database → **Import** → `schema.sql`, then `seed_data.sql`.

## Backing up the live database (Hostinger)

1. hPanel → **Databases → Management** → **Enter phpMyAdmin**.
2. Select the database → **Export** → Quick → SQL → **Export**.
3. Save as `Database/backups/afaqclinics_YYYY-MM-DD.sql` (never committed).

Hostinger's automatic copies: hPanel → **Files → Backups → Database backups**.
