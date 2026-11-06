-- Contradictory claims for the same property, amenity and scope.
SELECT property_id, amenity_id, scope, COUNT(DISTINCT state) AS state_count
FROM claims GROUP BY property_id, amenity_id, scope HAVING COUNT(DISTINCT state)>1;

-- Missing provenance. A present claim with an empty citation is not verified.
SELECT claim_id, property_id, amenity_id FROM claims
WHERE evidence_ref='' OR observed_on='';

-- Scope mismatch candidates for a human editor; do not change them automatically.
SELECT c.claim_id, c.scope, a.default_scope, a.review_note
FROM claims c JOIN amenities a ON c.amenity_id=a.amenity_id
WHERE c.scope<>a.default_scope;

-- Planned facilities cannot silently become currently available filters.
SELECT claim_id, property_id, amenity_id FROM claims WHERE state='planned';
