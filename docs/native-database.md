# Property Amenities Vocabulary

An editable RU/EN dictionary and SQL review model for property-catalogue teams. The database contains **37 authored amenity terms**, **80 exact language-labelled aliases**, **4 explicitly synthetic claim examples** and **4 executable review views**.

It keeps an amenity's meaning separate from where it applies, whether it is present or planned, who can use it and what source supports the claim. Missing data means **unknown**, not absent.

## Explore the database

```sh
dolt clone novasia/property-amenities-vocabulary
cd property-amenities-vocabulary
dolt sql -q "SELECT * FROM amenities;"
dolt sql -q "SELECT * FROM review_conflicting_claims;"
```

The tables are `amenities`, `aliases` and `claims`. The review views are:

- `review_conflicting_claims`: different claim states for one property/amenity/scope, for human review.
- `review_missing_provenance`: missing evidence reference or observation date.
- `review_scope_candidates`: a supplied scope differs from the vocabulary's default.
- `review_planned_facilities`: planned facilities that must not silently become current-availability filters.

Each view returns one deliberately constructed example in the bundled fixtures. Claims with IDs `DEMO-*`, properties `SYNTHETIC-*` and `fixture:` evidence references are invented. **The database contains no verified facts about real buildings.** Remove or replace synthetic examples before using your own claim data.

An exact alias helps with lookup; it does not prove availability. A shared pool does not imply private access, parking does not imply an assigned bay, and a lift alone does not certify a step-free route. Dates and citations are supplied observations, not authenticated evidence. Scope and state differences are review candidates, not automatic corrections.

## Reproduce and maintain

[Complete source, CSV exports, definitions and tests](https://github.com/novasia-estate/property-amenities-vocabulary) are public. To build a fresh empty SQL database from source, import `sql/vocabulary.sql`, `sql/synthetic-example.sql`, then `sql/views.sql`. Do not run the schema import on an already populated clone.

Use stable amenity IDs, keep aliases language-labelled and review changes as versioned table diffs. See [maintenance guidance](https://github.com/novasia-estate/property-amenities-vocabulary/blob/main/docs/maintenance.md).

Vocabulary and synthetic data: [CC0-1.0](https://creativecommons.org/publicdomain/zero/1.0/). Code: [MIT](https://github.com/novasia-estate/property-amenities-vocabulary/blob/main/LICENSE). These are authored editorial definitions, not an industry standard or facility certification.

Developed by [NovAsia Estate](https://novasia.estate/), publisher of property guides and research for Cambodia, Thailand and Bali.
