-- Portable MySQL/Dolt and SQLite schema. Absence of a claim never means absence of an amenity.
CREATE TABLE amenities (
  amenity_id VARCHAR(64) PRIMARY KEY,
  category VARCHAR(40) NOT NULL,
  default_scope VARCHAR(16) NOT NULL CHECK(default_scope IN ('unit','building','site','service')),
  label_en VARCHAR(120) NOT NULL,
  label_ru VARCHAR(120) NOT NULL,
  definition TEXT NOT NULL,
  review_note TEXT NOT NULL
);
CREATE TABLE aliases (
  language VARCHAR(8) NOT NULL,
  alias_text VARCHAR(160) NOT NULL,
  amenity_id VARCHAR(64) NOT NULL,
  PRIMARY KEY(language,alias_text),
  FOREIGN KEY(amenity_id) REFERENCES amenities(amenity_id)
);
CREATE TABLE claims (
  claim_id VARCHAR(64) PRIMARY KEY,
  property_id VARCHAR(64) NOT NULL,
  amenity_id VARCHAR(64) NOT NULL,
  scope VARCHAR(16) NOT NULL CHECK(scope IN ('unit','building','site','service')),
  state VARCHAR(20) NOT NULL CHECK(state IN ('present','absent','planned','unknown')),
  access_type VARCHAR(24) NOT NULL CHECK(access_type IN ('private','shared','paid','unspecified')),
  evidence_ref VARCHAR(500) NOT NULL,
  observed_on VARCHAR(10) NOT NULL,
  FOREIGN KEY(amenity_id) REFERENCES amenities(amenity_id)
);

INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('pool', 'leisure', 'site', 'Swimming pool', 'Бассейн', 'Pool intended for swimming or recreation.', 'Record completion, shared/private access and any fees; do not infer size.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Swimming pool', 'pool');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Бассейн', 'pool');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('children_pool', 'leisure', 'site', 'Children''s pool', 'Детский бассейн', 'Pool explicitly described as intended for children.', 'Does not establish depth, supervision or safety certification.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Children''s pool', 'children_pool');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Детский бассейн', 'children_pool');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('gym', 'leisure', 'building', 'Gym', 'Тренажёрный зал', 'Dedicated exercise room or fitness facility.', 'Record equipment and paid access separately if known.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Gym', 'gym');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Fitness room', 'gym');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Тренажёрный зал', 'gym');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Фитнес-зал', 'gym');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('sauna', 'leisure', 'building', 'Sauna', 'Сауна', 'Dry-heat bathing facility.', 'Do not map a steam room to a sauna automatically.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Sauna', 'sauna');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Сауна', 'sauna');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('steam_room', 'leisure', 'building', 'Steam room', 'Паровая комната', 'Humid-heat bathing facility.', 'Separate from sauna; verify operating status.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Steam room', 'steam_room');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Паровая комната', 'steam_room');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('playground', 'leisure', 'site', 'Playground', 'Детская площадка', 'Dedicated outdoor children''s play space.', 'Does not imply supervised childcare.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Playground', 'playground');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Детская площадка', 'playground');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('playroom', 'leisure', 'building', 'Children''s playroom', 'Детская игровая комната', 'Dedicated indoor children''s play space.', 'Childcare and supervised services require separate claims.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Children''s playroom', 'playroom');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Детская игровая комната', 'playroom');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('coworking', 'work', 'building', 'Coworking space', 'Коворкинг', 'Shared space explicitly offered for work.', 'Does not imply bookable private offices or included internet.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Coworking space', 'coworking');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Коворкинг', 'coworking');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('meeting_room', 'work', 'building', 'Meeting room', 'Переговорная', 'Room offered for meetings.', 'Record booking requirements and charges.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Meeting room', 'meeting_room');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Переговорная', 'meeting_room');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('parking', 'mobility', 'site', 'Parking', 'Парковка', 'Parking spaces available at the property site.', 'Does not imply an assigned bay, covered parking or free use.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Parking', 'parking');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Парковка', 'parking');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('covered_parking', 'mobility', 'site', 'Covered parking', 'Крытая парковка', 'Parking spaces protected by a roof or structure.', 'Do not infer enclosed or assigned parking.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Covered parking', 'covered_parking');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Крытая парковка', 'covered_parking');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('ev_charging', 'mobility', 'site', 'EV charging', 'Зарядка электромобилей', 'Equipment explicitly intended to charge electric vehicles.', 'Verify connector, capacity, operation and fees separately.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'EV charging', 'ev_charging');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Зарядка электромобилей', 'ev_charging');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('bicycle_storage', 'mobility', 'building', 'Bicycle storage', 'Хранение велосипедов', 'Designated space for keeping bicycles.', 'Does not imply a locked room or theft insurance.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Bicycle storage', 'bicycle_storage');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Хранение велосипедов', 'bicycle_storage');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('lift', 'access', 'building', 'Lift', 'Лифт', 'Passenger lift serving the building.', 'A lift alone does not prove a continuous step-free route.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Lift', 'lift');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Elevator', 'lift');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Лифт', 'lift');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Пассажирский лифт', 'lift');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('step_free_entrance', 'access', 'building', 'Step-free entrance', 'Вход без ступеней', 'An explicitly described entrance route without steps.', 'Not an accessibility certification; verify slopes, widths and route continuity.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Step-free entrance', 'step_free_entrance');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Вход без ступеней', 'step_free_entrance');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('concierge', 'services', 'service', 'Concierge', 'Консьерж', 'Staffed assistance described as concierge service.', 'Do not infer 24-hour coverage or included personal services.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Concierge', 'concierge');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Консьерж', 'concierge');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('reception', 'services', 'building', 'Reception desk', 'Стойка ресепшен', 'A staffed reception point.', 'Record working hours; reception is not equivalent to concierge.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Reception desk', 'reception');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Стойка ресепшен', 'reception');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('security_staff', 'security', 'service', 'Security staff', 'Охрана', 'On-site staff explicitly assigned a security role.', 'Do not infer hours, response time or a safety guarantee.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Security staff', 'security_staff');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Охрана', 'security_staff');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('cctv', 'security', 'site', 'CCTV', 'Видеонаблюдение', 'Cameras described as monitoring part of the site.', 'Does not establish complete coverage, retention or live monitoring.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'CCTV', 'cctv');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Video surveillance', 'cctv');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Видеонаблюдение', 'cctv');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Камеры наблюдения', 'cctv');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('controlled_entry', 'security', 'building', 'Controlled entry', 'Контроль доступа', 'An explicit access-control mechanism for entry.', 'Specify card, intercom or other mechanism if known.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Controlled entry', 'controlled_entry');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Контроль доступа', 'controlled_entry');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('backup_power', 'utilities', 'building', 'Backup power', 'Резервное электропитание', 'An alternative power supply for some circuits.', 'Record covered circuits and duration; do not promise whole-unit continuity.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Backup power', 'backup_power');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Резервное электропитание', 'backup_power');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('solar_generation', 'utilities', 'building', 'Solar electricity', 'Солнечная генерация', 'Photovoltaic electricity generation at the property.', 'Separate from solar water heating; capacity may be unknown.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Solar electricity', 'solar_generation');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Солнечная генерация', 'solar_generation');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('water_storage', 'utilities', 'building', 'Water storage', 'Резервуар воды', 'Water-storage capacity explicitly described for the building.', 'Storage alone does not establish potability or guaranteed supply.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Water storage', 'water_storage');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Резервуар воды', 'water_storage');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('internet_service', 'utilities', 'service', 'Internet service', 'Интернет', 'An offered internet connection or service.', 'Do not infer included subscription, speed or availability in every unit.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Internet service', 'internet_service');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Интернет', 'internet_service');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('air_conditioning', 'unit', 'unit', 'Air conditioning', 'Кондиционер', 'Air-conditioning equipment provided in the unit.', 'Record rooms, included installation and condition separately.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Air conditioning', 'air_conditioning');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Кондиционер', 'air_conditioning');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('balcony', 'unit', 'unit', 'Balcony', 'Балкон', 'An exterior platform associated with the unit.', 'Do not infer usable area or combine it with internal floor area.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Balcony', 'balcony');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Балкон', 'balcony');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('terrace', 'unit', 'unit', 'Terrace', 'Терраса', 'An exterior terrace associated with the unit.', 'Distinguish private access from common roof or podium space.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Terrace', 'terrace');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Терраса', 'terrace');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('private_garden', 'unit', 'unit', 'Private garden', 'Личный сад', 'Garden space explicitly allocated for private use.', 'Exclusive use is not proof of land ownership.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Private garden', 'private_garden');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Личный сад', 'private_garden');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('laundry_room', 'services', 'building', 'Laundry room', 'Прачечная', 'A shared room with laundry facilities.', 'Does not imply free use, serviced laundry or an in-unit washing machine.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Laundry room', 'laundry_room');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Прачечная', 'laundry_room');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('washing_machine', 'unit', 'unit', 'Washing machine', 'Стиральная машина', 'A washing machine explicitly provided in the unit.', 'Do not map communal laundry to this code.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Washing machine', 'washing_machine');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Стиральная машина', 'washing_machine');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('pet_policy', 'services', 'service', 'Pet policy', 'Правила содержания животных', 'A documented policy governing animals at the property.', 'This code does not itself mean pets are allowed; retain actual policy text.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Pet policy', 'pet_policy');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Правила содержания животных', 'pet_policy');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('beach_access', 'location', 'site', 'Direct beach access', 'Прямой выход к пляжу', 'An explicit route from the property directly to a beach.', 'Not equivalent to sea view, beachfront wording or legal access rights.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Direct beach access', 'beach_access');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Прямой выход к пляжу', 'beach_access');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('sea_view', 'unit', 'unit', 'Sea view', 'Вид на море', 'A claimed view of the sea from the specified unit.', 'Record viewpoint and obstruction; does not mean beach access.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Sea view', 'sea_view');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Вид на море', 'sea_view');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('rooftop_common_area', 'leisure', 'building', 'Shared rooftop area', 'Общая зона на крыше', 'Roof space offered for shared use.', 'Does not imply a pool, bar, private terrace or unrestricted access.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Shared rooftop area', 'rooftop_common_area');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Общая зона на крыше', 'rooftop_common_area');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('restaurant', 'services', 'site', 'Restaurant', 'Ресторан', 'A restaurant explicitly located within the site.', 'Do not infer included meals, ownership or permanent operation.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Restaurant', 'restaurant');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Ресторан', 'restaurant');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('shuttle', 'mobility', 'service', 'Shuttle service', 'Трансфер', 'A scheduled or on-demand transport service.', 'Record route, frequency, eligibility and fees instead of assuming them.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Shuttle service', 'shuttle');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Трансфер', 'shuttle');
INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('parcel_storage', 'services', 'building', 'Parcel storage', 'Хранение посылок', 'Designated parcel receipt or storage provision.', 'Does not imply 24-hour collection or acceptance of valuables.');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('en', 'Parcel storage', 'parcel_storage');
INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('ru', 'Хранение посылок', 'parcel_storage');
