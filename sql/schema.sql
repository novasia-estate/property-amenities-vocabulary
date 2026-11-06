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
