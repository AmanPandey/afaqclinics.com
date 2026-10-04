-- Afaq Clinics seed data, extracted from the website pages.
-- Load AFTER schema.sql:  mysql -u USER -p DB_NAME < seed_data.sql
SET NAMES utf8mb4;
START TRANSACTION;

INSERT INTO branches (name, slug, display_name, city, state, description) VALUES
  ('Tolichowki', 'tolichowki', 'Tolichowki, Hyderabad', 'Hyderabad', 'Telangana', 'The Tolichowki branch of Afaq Clinics stands as a hub for advanced and compassionate healthcare, catering to the vibrant and diverse community in the area. Conveniently located in one of Hyderabad''s prime neighborhoods, this branch is equipped with modern medical facilities and a team of expert professionals dedicated to providing patient-centered care. From family medicine and women’s health to pediatrics, dermatology, and diagnostic services, the Tolichowki branch offers a wide range of services tailored to meet the unique needs of every individual. Combining accessibility with high-quality care, Afaq Clinics'' Tolichowki branch is committed to enhancing the health and well-being of the community it serves.'),
  ('Chandrayangutta', 'chandrayangutta', 'Chandrayangutta, Hyderabad', 'Hyderabad', 'Telangana', 'The Chandrayangutta branch of Afaq Clinics is dedicated to delivering exceptional healthcare services with state-of-the-art facilities and a compassionate team of professionals. Strategically located to serve the vibrant community, this branch offers a comprehensive range of services, including family medicine, women’s health, pediatrics, dermatology, diagnostics, and chronic disease management. Designed to provide a welcoming and patient-centered environment, the Chandrayangutta branch ensures high-quality care that is accessible, affordable, and tailored to meet the unique needs of every individual.'),
  ('Khilwat', 'khilwat', 'Khilwat, Hyderabad', 'Hyderabad', 'Telangana', 'The Khilwat branch of Afaq Clinics is committed to delivering exceptional healthcare services to the heart of Hyderabad''s historic district. Nestled in the vibrant Khilwat area, this branch offers a perfect blend of modern medical facilities and compassionate care, ensuring that every patient receives personalized attention. With a wide range of services, including family medicine, pediatrics, women’s health, dermatology, diagnostics, and chronic disease management, the Khilwat branch addresses the diverse healthcare needs of the community. Designed to provide a welcoming and patient-focused environment, Afaq Clinics'' Khilwat branch is dedicated to enhancing health outcomes and promoting well-being for individuals and families alike.');

INSERT INTO departments (name, slug, page_url, sort_order) VALUES
  ('Cardiology', 'cardiology', '/department/cardiology', 1),
  ('Cosmetic Dermatology', 'cosmetic-dermatology', '/department/cosmetic-dermatology', 2),
  ('Dermatology', 'dermatology', '/department/dermatology', 3),
  ('Endocrinology', 'endocrinology', '/department/endocrinology', 4),
  ('ENT', 'ent', '/department/ent', 5),
  ('Fertility and IVF', 'fertility-ivf', '/department/fertility-ivf', 6),
  ('General Medicine', 'general-medicine', '/department/general-medicine', 7),
  ('Hair Transplant', 'hair-transplant', '/department/hair-transplant', 8),
  ('Nephrology', 'nephrology', '/department/nephrology', 9),
  ('Neurology', 'neurology', '/department/neurology', 10),
  ('Obstetrics & Gynecology', 'obstetrics-gynecology', '/department/obstetrics-gynecology', 11),
  ('Oncology', 'oncology', '/department/oncology', 12),
  ('Organ Transplant', 'organ-transplant', '/department/organ-transplant', 13),
  ('Orthopedics', 'orthopedics', '/department/orthopedics', 14),
  ('Pediatrics', 'pediatrics', '/department/pediatrics', 15),
  ('Plastic Surgery', 'plastic-surgery', '/department/plastic-surgery', 16),
  ('Pulmonology', 'pulmonology', '/department/pulmonology', 17),
  ('Rheumatology', 'rheumatology', '/department/rheumatology', 18),
  ('Slimming & Weight Loss', 'slimming-weight-loss', '/department/slimming-weight-loss', 19),
  ('Slimming and Weight Management', 'slimming-weight-management', '/department/slimming-weight-management', 20),
  ('Urology', 'urology', '/department/urology', 21);

INSERT INTO services (name, slug, page_url, sort_order) VALUES
  ('Acne Treatment', 'acne-treatment', '/service/acne-treatment', 1),
  ('Anti-Aging Solutions', 'anti-aging-solutions', '/service/anti-aging-solutions', 2),
  ('Cardiology Services', 'cardiology-services', '/service/cardiology-services', 3),
  ('Chronic Disease Management (Diabetes, Hypertension, etc.)', 'chronic-disease-management', '/service/chronic-disease-management', 4),
  ('Dermatology and Aesthetic Treatments', 'dermatology-and-aesthetic-treatments', '/service/dermatology-and-aesthetic-treatments', 5),
  ('ENT (Ear, Nose, and Throat) Services', 'ent-ear-nose-throat-services', '/service/ent-ear-nose-throat-services', 6),
  ('Family Physician Consultations', 'family-physician-consultations', '/service/family-physician-consultations', 7),
  ('Fertility and IVF Treatments', 'fertility-and-ivf-treatments', '/service/fertility-and-ivf-treatments', 8),
  ('Gastroenterology and Digestive Health', 'gastroenterology-and-digestive-health', '/service/gastroenterology-and-digestive-health', 9),
  ('General Medicine', 'general-medicine', '/service/general-medicine', 10),
  ('Geriatric Care (Elderly Health Services)', 'geriatric-care-elderly-health-services', '/service/geriatric-care-elderly-health-services', 11),
  ('Minor Surgical Procedures', 'minor-surgical-procedures', '/service/minor-surgical-procedures', 12),
  ('Neurology and Neurosurgery', 'neurology-and-neurosurgery', '/service/neurology-and-neurosurgery', 13),
  ('Orthopedics and Joint Care', 'orthopedics-and-joint-care', '/service/orthopedics-and-joint-care', 14),
  ('Pediatrics and Child Care', 'pediatrics-and-child-care', '/service/pediatrics-and-child-care', 15),
  ('Skin Rejuvenation', 'skin-rejuvenation', '/service/skin-rejuvenation', 16),
  ('Urology Services', 'urology-services', '/service/urology-services', 17),
  ('Vaccinations and Immunizations', 'vaccinations-and-immunizations', '/service/vaccinations-and-immunizations', 18),
  ('Women’s Health (Gynecology and Obstetrics)', 'womens-health-gynecology-obstetrics', '/service/womens-health-gynecology-obstetrics', 19);

INSERT INTO offers (name, slug, headline, original_price, offer_price, description, sort_order) VALUES
  ('Amniocentesis', 'amniocentesis', 'Special discount on amniocentesis', 5000.0, 4500.0, 'Accurate prenatal testing for expecting mothers. Prenatal screening for fetal health.', 1),
  ('Basic Metabolic Panel', 'basic-metabolic-panel', 'Discount on basic metabolic panel', 2000.0, 1800.0, 'Comprehensive metabolic panel for overall health. Screen for various metabolic functions.', 2),
  ('Biopsy', 'biopsy', 'Discount on biopsy tests', 3500.0, 3150.0, 'Accurate biopsy for precise diagnosis. Detailed tissue analysis for diagnosis.', 3),
  ('Blood Pressure Measurement', 'blood-pressure-measurement', 'Special discount on blood pressure measurement', 500.0, 475.0, 'Regular blood pressure checks for a healthy heart. Accurate blood pressure monitoring.', 4),
  ('Blood Test', 'blood-test', 'Discount on complete blood tests', 1000.0, 950.0, 'Accurate and complete blood tests. Comprehensive blood testing.', 5),
  ('Bone Marrow Aspiration', 'bone-marrow-aspiration', 'Discount on bone marrow aspiration', 6000.0, 5700.0, 'Precise bone marrow aspiration testing. Detailed analysis of bone marrow.', 6),
  ('Cardiology', 'cardiology', 'Discount on cardiology services', 10000.0, 9000.0, 'Advanced cardiac treatments for a healthy heart. Comprehensive heart care services.', 7),
  ('Clinical Dermatology', 'clinical-dermatology', 'Special discount on dermatology services', 4500.0, 3825.0, 'Professional skin care for healthy skin. Effective treatments for various skin conditions.', 8),
  ('Colonoscopy', 'colonoscopy', 'Discount on colonoscopy', 4000.0, 3400.0, 'Comprehensive colon health screening. Detailed examination of the colon.', 9),
  ('Dermatology', 'dermatology', 'Special discount on all dermatology procedures', 5000.0, 4000.0, 'Advanced cosmetic solutions for a youthful appearance. We offer advanced cosmetic dermatology treatments to bring out your best.', 10),
  ('Electrolytes', 'electrolytes', 'Discount on electrolyte tests', 1000.0, 900.0, 'Accurate analysis of essential electrolytes. Essential electrolyte level analysis.', 11),
  ('Endoscopy', 'endoscopy', 'Discount on endoscopy', 5000.0, 4250.0, 'Detailed endoscopy for accurate diagnosis. Examine the internal organs in detail.', 12),
  ('Ent', 'ent', 'Comprehensive ENT care with special discount', 6000.0, 5100.0, 'Top-notch ENT services for all ages. Our ENT specialists provide top-notch care for ear, nose, and throat conditions.', 13),
  ('Fertility', 'fertility', 'Special package for fertility treatments', 12000.0, 10800.0, 'Empowering families with fertility solutions. Comprehensive fertility solutions to help families grow.', 14),
  ('Gynecology', 'gynecology', 'Discount on all gynecological services', 8000.0, 6400.0, 'Expert care for women''s health. Providing expert gynecological care for women of all ages.', 15),
  ('Hair Transplant', 'hair-transplant', 'Hair transplant services with a special discount', 10000.0, 8500.0, 'Revitalize your look with our hair transplant services. Effective hair restoration services for men and women.', 16),
  ('Liver Function Test', 'liver-function-test', 'Special discount on liver function tests', 1800.0, 1530.0, 'Assess liver health with comprehensive testing. Detailed liver function assessment.', 17),
  ('Neurology', 'neurology', 'Discount on neurology services', 11000.0, 9900.0, 'Leading-edge neurology services. Specialized care for neurological conditions.', 18),
  ('Oncology', 'oncology', 'Special discount on oncology services', 15000.0, 11250.0, 'Innovative cancer care solutions. Leading-edge cancer treatments to fight cancer effectively.', 19),
  ('Organ Transplant', 'organ-transplant', 'Discount on organ transplant services', 50000.0, 47500.0, 'Life-saving organ transplants. Expert organ transplant services to save lives.', 20),
  ('Orthopaedic', 'orthopaedic', 'Special discount on orthopaedic treatments', 7000.0, 6300.0, 'Advanced orthopaedic solutions for better mobility. Comprehensive bone and joint care.', 21),
  ('Rheumatology', 'rheumatology', 'Discount on rheumatology services', 6500.0, 5525.0, 'Expert care for joint and autoimmune conditions. Specialized care for rheumatic diseases.', 22),
  ('Slimming', 'slimming', 'Discount on slimming programs', 3000.0, 2400.0, 'Get fit with our specialized slimming programs. Personalized slimming programs for effective weight loss.', 23),
  ('Thyroid Function Tests', 'thyroid-function-tests', 'Special discount on thyroid function tests', 1500.0, 1350.0, 'Accurate thyroid function testing for all ages. Detailed thyroid tests to assess thyroid health.', 24),
  ('Urology', 'urology', 'Discount on urology services', 9000.0, 7200.0, 'Specialized urology services for all ages. Comprehensive care for urinary and reproductive health.', 25);

INSERT INTO insights (title, slug, page_url, status) VALUES
  ('Afaq Clinics: Your Trusted Partner in Global Healthcare Journeys', 'afaq-clinics-global-healthcare', '/insight/afaq-clinics-global-healthcare', 'published'),
  ('How Anti-Aging Solutions Can Transform Your Skin', 'anti-aging-solutions-transform-skin', '/insight/anti-aging-solutions-transform-skin', 'published'),
  ('The Benefits of Professional Skin Rejuvenation Treatments', 'benefits-of-skin-rejuvenation', '/insight/benefits-of-skin-rejuvenation', 'published'),
  ('Common Health Issues in Children and How to Address Them', 'common-health-issues-children', '/insight/common-health-issues-children', 'published'),
  ('Dermatology Essentials: What to Know Before Your First Visit', 'dermatology-essentials-first-visit', '/insight/dermatology-essentials-first-visit', 'published'),
  ('Building a Strong Doctor-Patient Relationship: Why It Matters for Your Health', 'doctor-patient-relationship', '/insight/doctor-patient-relationship', 'published'),
  ('Why Hyderabad is Emerging as a Hub for Medical Tourism', 'hyderabad-medical-tourism', '/insight/hyderabad-medical-tourism', 'published'),
  ('The Importance of Regular Health Check-Ups for Your Family', 'importance-of-regular-health-checkups', '/insight/importance-of-regular-health-checkups', 'published'),
  ('Managing Chronic Diseases: Tips for Long-Term Wellness', 'managing-chronic-diseases', '/insight/managing-chronic-diseases', 'published'),
  ('Breaking Barriers: Multilingual Support for International Patients at Afaq Clinics', 'multilingual-support-afaq-clinics', '/insight/multilingual-support-afaq-clinics', 'published'),
  ('Debunking Myths About Fertility and IVF Treatments', 'myths-about-fertility-ivf', '/insight/myths-about-fertility-ivf', 'published'),
  ('The Role of Nutrition and Exercise in Women’s Health', 'nutrition-exercise-womens-health', '/insight/nutrition-exercise-womens-health', 'published'),
  ('How to Plan Your Medical Trip to India: A Step-by-Step Guide', 'plan-your-medical-trip-india', '/insight/plan-your-medical-trip-india', 'published'),
  ('How Preventive Healthcare Can Save Lives: Insights from Afaq Clinics', 'preventive-healthcare-saves-lives', '/insight/preventive-healthcare-saves-lives', 'published'),
  ('Top Benefits of Regular Gynecological Check-Ups', 'regular-gynecological-checkups', '/insight/regular-gynecological-checkups', 'published'),
  ('Top Skincare Tips for Healthy, Glowing Skin', 'skincare-tips-glowing-skin', '/insight/skincare-tips-glowing-skin', 'published'),
  ('Top Tips for International Patients Visiting Afaq Clinics', 'top-tips-international-patients', '/insight/top-tips-international-patients', 'published'),
  ('Understanding Acne: Causes, Treatment, and Prevention', 'understanding-acne-treatment-prevention', '/insight/understanding-acne-treatment-prevention', 'published');

INSERT INTO events_awards (title, description, recipient, sort_order) VALUES
  ('Dr. Arjumand Afaq Awarded for Excellence', 'Dr. Arjumand Afaq was honored by the Lions Club Hyderabad for her exceptional contributions and dedicated service to society. This prestigious award recognizes her commitment to providing outstanding healthcare and community welfare.', 'Dr. Arjumand Afaq', 1),
  ('Dr. Arjumand Afaq Honored on Women''s Day', 'Dr. Arjumand Afaq was awarded by Continental Hospital on Women''s Day in recognition of her exemplary contributions to women''s health and empowerment. This accolade highlights her dedication to advancing healthcare for women.', 'Dr. Arjumand Afaq', 2),
  ('Dr. Arjumand Afaq Honored by Care Hospital on Women''s Day', 'Dr. Arjumand Afaq received a prestigious award from Care Hospital on Women''s Day, celebrating her significant contributions to women''s healthcare and her dedication to improving lives.', 'Dr. Arjumand Afaq', 3),
  ('Doctors Day Award to Dr. Arjumand Afaq', 'Dr. Arjumand Afaq was honored on Doctors Day for her exceptional dedication and commitment to providing outstanding healthcare services to the community.', 'Dr. Arjumand Afaq', 4),
  ('Global Healthcare Excellence Award to Dr. Arjumand Afaq', 'Dr. Arjumand Afaq was honored with the prestigious Global Healthcare Excellence Award for her remarkable contributions to advancing healthcare and fostering international collaborations in the field of medicine. This recognition celebrates her relentless dedication to patient care and her efforts to bring innovation to the healthcare sector.', 'Dr. Arjumand Afaq', 5),
  ('Excellence in Community Service Award', 'Dr. Arjumand Afaq was honored with the Excellence in Community Service Award by the Hyderabad Police Department. This award recognizes her tireless efforts and outstanding contributions towards improving healthcare access and fostering well-being within the local community.', 'Dr. Arjumand Afaq', 6),
  ('Recognition by Hyderabad South Zone Police', 'Dr. Arjumand Afaq received recognition from the Hyderabad South Zone Police, led by the Commissioner, for her invaluable contributions to healthcare through free mega health camps and community welfare initiatives. This award highlights her dedication to improving the well-being of the underprivileged in collaboration with law enforcement efforts.', 'Dr. Arjumand Afaq', 7),
  ('Honor from Care Hospitals, Nampally', 'Dr. Arjumand Afaq was honored by Care Hospitals, Nampally, for her outstanding contributions to healthcare and her unwavering commitment to patient care. This recognition underscores her dedication to improving lives through excellence in medical services.', 'Dr. Arjumand Afaq', 8),
  ('Prestigious Global Recognition for Dr. Arjumand Afaq', 'Dr. Arjumand Afaq was honored with an esteemed international award for her exceptional contributions to healthcare and her unwavering dedication to improving global medical standards. This recognition celebrates her impactful work and her commitment to advancing patient care on a global platform.', 'Dr. Arjumand Afaq', 9),
  ('Subscribe!', 'Sign up with your email to receive the latest updates directly in your inbox!', 'Dr. Arjumand Afaq', 10);

INSERT INTO site_settings (setting_key, setting_value) VALUES
  ('site_name', 'Afaq Clinics'),
  ('contact_email', 'info@afaqclinics.com'),
  ('contact_phone', '+919700948434');

COMMIT;
