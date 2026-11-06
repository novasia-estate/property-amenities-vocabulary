# Maintain a useful dictionary

Add a new code only when it expresses a distinct filterable fact. Keep aliases exact and language-labelled. Never turn a developer's marketing phrase into a verified facility automatically. Add a review note when access, completion, location or fees can change the meaning.

Review vocabulary changes as table diffs: stable codes should not silently change meaning. Deprecate an old code explicitly in a future schema migration rather than repurposing it. Keep source claim history in your database or version control. CSV exports contain only the dictionary; claims remain a separate dataset.

To add Thai, Khmer or Indonesian labels, extend a separate labels/aliases table with a language code and review by a speaker. Do not use generated translations as authoritative definitions without review.

All bundled examples are synthetic and use fixture references. They must not be mixed into production claim tables.
