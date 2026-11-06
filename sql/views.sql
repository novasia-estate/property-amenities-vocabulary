CREATE VIEW review_conflicting_claims AS
SELECT property_id, amenity_id, scope, COUNT(DISTINCT state) AS state_count
FROM claims GROUP BY property_id, amenity_id, scope HAVING COUNT(DISTINCT state)>1;

CREATE VIEW review_missing_provenance AS
SELECT claim_id, property_id, amenity_id FROM claims
WHERE evidence_ref='' OR observed_on='';

CREATE VIEW review_scope_candidates AS
SELECT c.claim_id, c.scope, a.default_scope, a.review_note
FROM claims c JOIN amenities a ON c.amenity_id=a.amenity_id
WHERE c.scope<>a.default_scope;

CREATE VIEW review_planned_facilities AS
SELECT claim_id, property_id, amenity_id FROM claims WHERE state='planned';
