# Property Amenities Vocabulary

A small, editable bilingual RU/EN dictionary and SQL review model for property catalogues. It prevents a pool mentioned in a brochure, a planned pool and a currently shared pool from being flattened into one misleading yes/no field.

The authored vocabulary provides stable amenity codes, labels, explicit aliases, default scope, definitions and practical review notes. The claim table separately records **scope**, **present / absent / planned / unknown**, **access**, an evidence reference and an observation date. An omitted claim means **unknown**, not absent.

This is a proposed editorial data model, not an industry standard, a facility certification, a market dataset or a legal accessibility specification. Definitions describe how these fields are used in this project. No real buildings, prices or facilities are asserted. Review local terms and the actual source before using a filter publicly.

## Files and use

- `data/terms.json`: canonical authored vocabulary.
- `data/amenities.csv`, `data/aliases.csv`: deterministic exports.
- `sql/schema.sql`: MySQL/Dolt and SQLite table definitions.
- `sql/vocabulary.sql`: schema and complete dictionary inserts.
- `sql/review.sql`: contradictions, missing provenance, scope mismatch and planned-facility queues.
- `sql/synthetic-example.sql`: deliberately conflicting, invented claims.
- `tools/build.py`: validates aliases and rebuilds SQL/CSV.
- `tests/`: data contracts and executable review scenarios.

```sh
# Dolt / MySQL-compatible vocabulary import:
dolt sql < sql/vocabulary.sql
# Then load your reviewed claims, or explore clearly synthetic examples:
dolt sql < sql/synthetic-example.sql
dolt sql < sql/review.sql

# Dependency-free local verification:
python tools/build.py
python -m unittest discover -s tests -v
```

An exact alias is a lookup aid, not permission to infer availability. “Near the beach” is deliberately separate from direct beach access; parking does not imply an assigned private bay; a lift alone does not prove a step-free route. Default scope mismatches are review candidates, not errors to fix blindly.

Dates are supplied source observations, not freshness guarantees. The schema does not authenticate citations or validate real calendar dates; application ingestion should do so. There is no fuzzy language matching. See [maintenance](docs/maintenance.md).

Vocabulary and synthetic data: CC0-1.0. Code: MIT. Developed by [NovAsia Estate](https://novasia.estate/), publisher of property guides for Cambodia, Thailand and Bali.
