-- =====================================================================
--  Afaq Clinics - complete database schema (MySQL 5.7+ / MariaDB 10.3+)
-- =====================================================================
--  Reconstructed from the website (the original DB was not in the
--  HTTrack copy). Covers site content + every form on the site.
--
--  Install:
--    1. mysql -u USER -p DB_NAME < schema.sql
--    2. mysql -u USER -p DB_NAME < seed_data.sql   (content from the site)
--  or phpMyAdmin -> Import, same order.
-- =====================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------
--  1. ADMIN / STAFF
-- ---------------------------------------------------------------------

-- People who log in to manage the site and appointments
CREATE TABLE IF NOT EXISTS admin_users (
    id             INT UNSIGNED NOT NULL AUTO_INCREMENT,
    full_name      VARCHAR(150) NOT NULL,
    email          VARCHAR(255) NOT NULL,
    password_hash  VARCHAR(255) NOT NULL,          -- password_hash() / bcrypt, never plain text
    role           ENUM('super_admin','admin','receptionist','editor') NOT NULL DEFAULT 'receptionist',
    branch_id      INT UNSIGNED NULL,              -- NULL = all branches
    is_active      TINYINT(1)   NOT NULL DEFAULT 1,
    last_login_at  DATETIME     NULL,
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_admin_email (email),
    KEY idx_admin_branch (branch_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
--  2. CLINIC STRUCTURE
-- ---------------------------------------------------------------------

-- branches.html : Tolichowki, Chandrayangutta, Khilwat
CREATE TABLE IF NOT EXISTS branches (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name          VARCHAR(100) NOT NULL,
    slug          VARCHAR(120) NOT NULL,
    display_name  VARCHAR(150) NOT NULL,
    address       VARCHAR(255) NULL,
    city          VARCHAR(100) NOT NULL DEFAULT 'Hyderabad',
    state         VARCHAR(100) NOT NULL DEFAULT 'Telangana',
    pincode       VARCHAR(10)  NULL,
    phone         VARCHAR(20)  NULL,
    email         VARCHAR(255) NULL,
    map_url       VARCHAR(500) NULL,
    image         VARCHAR(255) NULL,
    description   TEXT         NULL,
    opening_hours VARCHAR(255) NULL,
    is_active     TINYINT(1)   NOT NULL DEFAULT 1,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_branch_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- department/*.html  (Cardiology, Dermatology, ENT, ...)
CREATE TABLE IF NOT EXISTS departments (
    id                INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name              VARCHAR(150) NOT NULL,
    slug              VARCHAR(160) NOT NULL,
    page_url          VARCHAR(255) NULL,
    short_description VARCHAR(500) NULL,
    content           LONGTEXT     NULL,
    image             VARCHAR(255) NULL,
    icon              VARCHAR(255) NULL,
    meta_title        VARCHAR(255) NULL,
    meta_description  VARCHAR(500) NULL,
    sort_order        INT          NOT NULL DEFAULT 0,
    is_active         TINYINT(1)   NOT NULL DEFAULT 1,
    created_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_department_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Which departments are available at which branch
CREATE TABLE IF NOT EXISTS branch_departments (
    branch_id     INT UNSIGNED NOT NULL,
    department_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (branch_id, department_id),
    CONSTRAINT fk_bd_branch     FOREIGN KEY (branch_id)     REFERENCES branches(id)    ON DELETE CASCADE,
    CONSTRAINT fk_bd_department FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- service/*.html  (Acne Treatment, Cardiology Services, ...)
CREATE TABLE IF NOT EXISTS services (
    id                INT UNSIGNED NOT NULL AUTO_INCREMENT,
    department_id     INT UNSIGNED NULL,
    name              VARCHAR(200) NOT NULL,
    slug              VARCHAR(210) NOT NULL,
    page_url          VARCHAR(255) NULL,
    short_description VARCHAR(500) NULL,
    content           LONGTEXT     NULL,
    image             VARCHAR(255) NULL,
    meta_title        VARCHAR(255) NULL,
    meta_description  VARCHAR(500) NULL,
    sort_order        INT          NOT NULL DEFAULT 0,
    is_active         TINYINT(1)   NOT NULL DEFAULT 1,
    created_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_service_slug (slug),
    KEY idx_service_department (department_id),
    CONSTRAINT fk_service_department FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Doctors (Dr. Arjumand Afaq and team)
CREATE TABLE IF NOT EXISTS doctors (
    id               INT UNSIGNED NOT NULL AUTO_INCREMENT,
    full_name        VARCHAR(150) NOT NULL,
    slug             VARCHAR(160) NOT NULL,
    designation      VARCHAR(150) NULL,
    qualifications   VARCHAR(255) NULL,
    experience_years TINYINT UNSIGNED NULL,
    bio              TEXT         NULL,
    photo            VARCHAR(255) NULL,
    languages        VARCHAR(255) NULL,          -- e.g. 'English, Hindi, Urdu, Arabic'
    is_active        TINYINT(1)   NOT NULL DEFAULT 1,
    sort_order       INT          NOT NULL DEFAULT 0,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_doctor_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS doctor_departments (
    doctor_id     INT UNSIGNED NOT NULL,
    department_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (doctor_id, department_id),
    CONSTRAINT fk_dd_doctor     FOREIGN KEY (doctor_id)     REFERENCES doctors(id)     ON DELETE CASCADE,
    CONSTRAINT fk_dd_department FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Weekly OPD timings per doctor per branch
CREATE TABLE IF NOT EXISTS doctor_schedules (
    id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    doctor_id   INT UNSIGNED NOT NULL,
    branch_id   INT UNSIGNED NOT NULL,
    day_of_week TINYINT UNSIGNED NOT NULL,      -- 1 = Monday ... 7 = Sunday
    start_time  TIME NOT NULL,
    end_time    TIME NOT NULL,
    PRIMARY KEY (id),
    KEY idx_schedule_lookup (branch_id, day_of_week),
    CONSTRAINT fk_ds_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(id)  ON DELETE CASCADE,
    CONSTRAINT fk_ds_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
--  3. MARKETING CONTENT
-- ---------------------------------------------------------------------

-- offer/*.html  (Blood Test Offer: Rs 1,000 -> Rs 950, ...)
CREATE TABLE IF NOT EXISTS offers (
    id             INT UNSIGNED NOT NULL AUTO_INCREMENT,
    department_id  INT UNSIGNED NULL,
    name           VARCHAR(150) NOT NULL,
    slug           VARCHAR(160) NOT NULL,
    headline       VARCHAR(255) NULL,
    description    TEXT         NULL,
    original_price DECIMAL(10,2) NULL,
    offer_price    DECIMAL(10,2) NULL,
    image          VARCHAR(255) NULL,
    valid_from     DATE NULL,
    valid_until    DATE NULL,
    sort_order     INT          NOT NULL DEFAULT 0,
    is_active      TINYINT(1)   NOT NULL DEFAULT 1,
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_offer_slug (slug),
    KEY idx_offer_active (is_active, valid_until),
    CONSTRAINT fk_offer_department FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- insight/*.html  (blog articles)
CREATE TABLE IF NOT EXISTS insight_categories (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name       VARCHAR(100) NOT NULL,
    slug       VARCHAR(110) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_insight_cat_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS insights (
    id               INT UNSIGNED NOT NULL AUTO_INCREMENT,
    category_id      INT UNSIGNED NULL,
    author_id        INT UNSIGNED NULL,          -- admin_users.id
    title            VARCHAR(255) NOT NULL,
    slug             VARCHAR(255) NOT NULL,
    page_url         VARCHAR(255) NULL,
    excerpt          VARCHAR(500) NULL,
    content          LONGTEXT     NULL,
    featured_image   VARCHAR(255) NULL,
    meta_title       VARCHAR(255) NULL,
    meta_description VARCHAR(500) NULL,
    status           ENUM('draft','published','archived') NOT NULL DEFAULT 'draft',
    views            INT UNSIGNED NOT NULL DEFAULT 0,
    published_at     DATETIME     NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_insight_slug (slug),
    KEY idx_insight_status (status, published_at),
    CONSTRAINT fk_insight_category FOREIGN KEY (category_id) REFERENCES insight_categories(id) ON DELETE SET NULL,
    CONSTRAINT fk_insight_author   FOREIGN KEY (author_id)   REFERENCES admin_users(id)        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- events-awards.html
CREATE TABLE IF NOT EXISTS events_awards (
    id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    type        ENUM('award','event') NOT NULL DEFAULT 'award',
    title       VARCHAR(255) NOT NULL,
    description TEXT         NULL,
    recipient   VARCHAR(150) NULL,
    awarded_by  VARCHAR(150) NULL,
    event_date  DATE         NULL,
    image       VARCHAR(255) NULL,
    sort_order  INT          NOT NULL DEFAULT 0,
    is_active   TINYINT(1)   NOT NULL DEFAULT 1,
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Patient reviews shown on the site
CREATE TABLE IF NOT EXISTS testimonials (
    id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
    patient_name VARCHAR(150) NOT NULL,
    location     VARCHAR(150) NULL,
    rating       TINYINT UNSIGNED NULL,          -- 1..5
    message      TEXT         NOT NULL,
    photo        VARCHAR(255) NULL,
    is_approved  TINYINT(1)   NOT NULL DEFAULT 0,
    created_at   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Home page slider
CREATE TABLE IF NOT EXISTS banners (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    title      VARCHAR(255) NULL,
    subtitle   VARCHAR(255) NULL,
    image      VARCHAR(255) NOT NULL,
    link_url   VARCHAR(255) NULL,
    sort_order INT          NOT NULL DEFAULT 0,
    is_active  TINYINT(1)   NOT NULL DEFAULT 1,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
--  4. FORM SUBMISSIONS (leads / patient data - treat as confidential)
-- ---------------------------------------------------------------------

-- "Book Your Appointment" form  (fields: fullName, mobile, city, date)
CREATE TABLE IF NOT EXISTS appointments (
    id               INT UNSIGNED NOT NULL AUTO_INCREMENT,
    full_name        VARCHAR(150) NOT NULL,
    mobile           VARCHAR(20)  NOT NULL,
    email            VARCHAR(255) NULL,
    city             VARCHAR(100) NOT NULL,
    appointment_date DATE         NOT NULL,
    appointment_time TIME         NULL,
    branch_id        INT UNSIGNED NULL,
    department_id    INT UNSIGNED NULL,
    doctor_id        INT UNSIGNED NULL,
    offer_id         INT UNSIGNED NULL,          -- booked from an offer page
    source_page      VARCHAR(255) NULL,          -- URL the form was submitted from
    notes            TEXT         NULL,
    status           ENUM('new','confirmed','completed','cancelled','no_show') NOT NULL DEFAULT 'new',
    handled_by       INT UNSIGNED NULL,          -- admin_users.id
    ip_address       VARCHAR(45)  NULL,
    user_agent       VARCHAR(255) NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_appt_date   (appointment_date),
    KEY idx_appt_status (status),
    KEY idx_appt_mobile (mobile),
    CONSTRAINT fk_appt_branch     FOREIGN KEY (branch_id)     REFERENCES branches(id)    ON DELETE SET NULL,
    CONSTRAINT fk_appt_department FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL,
    CONSTRAINT fk_appt_doctor     FOREIGN KEY (doctor_id)     REFERENCES doctors(id)     ON DELETE SET NULL,
    CONSTRAINT fk_appt_offer      FOREIGN KEY (offer_id)      REFERENCES offers(id)      ON DELETE SET NULL,
    CONSTRAINT fk_appt_admin      FOREIGN KEY (handled_by)    REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- contact.html form  (fields: fullName, mobileNumber, message)
CREATE TABLE IF NOT EXISTS contact_messages (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    full_name     VARCHAR(150) NOT NULL,
    mobile_number VARCHAR(20)  NOT NULL,
    email         VARCHAR(255) NULL,
    message       TEXT         NOT NULL,
    status        ENUM('new','read','replied','closed') NOT NULL DEFAULT 'new',
    ip_address    VARCHAR(45)  NULL,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_contact_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- international-patients.html enquiry (visa, translator, travel, stay)
CREATE TABLE IF NOT EXISTS international_enquiries (
    id                  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    full_name           VARCHAR(150) NOT NULL,
    email               VARCHAR(255) NULL,
    phone               VARCHAR(30)  NOT NULL,      -- with country code
    country             VARCHAR(100) NOT NULL,
    preferred_language  VARCHAR(50)  NULL,
    department_id       INT UNSIGNED NULL,
    medical_condition   TEXT         NULL,
    needs_visa_help     TINYINT(1)   NOT NULL DEFAULT 0,
    needs_translator    TINYINT(1)   NOT NULL DEFAULT 0,
    needs_accommodation TINYINT(1)   NOT NULL DEFAULT 0,
    needs_airport_pickup TINYINT(1)  NOT NULL DEFAULT 0,
    expected_travel_date DATE        NULL,
    status              ENUM('new','in_progress','converted','closed') NOT NULL DEFAULT 'new',
    created_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_intl_status (status),
    CONSTRAINT fk_intl_department FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Medical reports uploaded with an international enquiry
CREATE TABLE IF NOT EXISTS enquiry_attachments (
    id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    enquiry_id  INT UNSIGNED NOT NULL,
    file_path   VARCHAR(255) NOT NULL,           -- store OUTSIDE public_html
    file_name   VARCHAR(255) NOT NULL,
    mime_type   VARCHAR(100) NULL,
    size_bytes  INT UNSIGNED NULL,
    uploaded_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_attach_enquiry FOREIGN KEY (enquiry_id) REFERENCES international_enquiries(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- insights*.html newsletter form -> subscribe.php  (field: email)
CREATE TABLE IF NOT EXISTS newsletter_subscribers (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    email           VARCHAR(255) NOT NULL,
    status          ENUM('subscribed','unsubscribed') NOT NULL DEFAULT 'subscribed',
    unsubscribe_token CHAR(64)   NULL,
    ip_address      VARCHAR(45)  NULL,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    unsubscribed_at DATETIME     NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_subscriber_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
--  5. SETTINGS
-- ---------------------------------------------------------------------

-- Phone, email, social links, etc. shown in header/footer
CREATE TABLE IF NOT EXISTS site_settings (
    setting_key   VARCHAR(100) NOT NULL,
    setting_value TEXT         NULL,
    updated_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (setting_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- admin_users.branch_id FK added last (branches created after admin_users)
ALTER TABLE admin_users
    ADD CONSTRAINT fk_admin_branch FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE SET NULL;

SET FOREIGN_KEY_CHECKS = 1;
