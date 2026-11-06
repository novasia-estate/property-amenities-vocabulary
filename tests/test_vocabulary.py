import pathlib,sqlite3,unittest,sys,json,csv
ROOT=pathlib.Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT/'tools'))
from build import build
class VocabularyTests(unittest.TestCase):
    def setUp(self):
        self.db=sqlite3.connect(':memory:');self.db.execute('PRAGMA foreign_keys=ON');self.db.executescript((ROOT/'sql/vocabulary.sql').read_text(encoding='utf8'))
    def test_round_trip_counts(self):
        terms=json.loads((ROOT/'data/terms.json').read_text(encoding='utf8'));self.assertEqual(self.db.execute('SELECT COUNT(*) FROM amenities').fetchone()[0],len(terms))
    def test_bilingual_labels(self):self.assertEqual(self.db.execute("SELECT COUNT(*) FROM amenities WHERE label_en='' OR label_ru=''").fetchone()[0],0)
    def test_alias_integrity(self):self.assertEqual(self.db.execute('SELECT COUNT(*) FROM aliases a LEFT JOIN amenities b ON a.amenity_id=b.amenity_id WHERE b.amenity_id IS NULL').fetchone()[0],0)
    def test_surveillance_aliases_mean_cctv(self):
        for lang,alias in [('en','Video surveillance'),('ru','Камеры наблюдения')]:
            self.assertEqual(self.db.execute('SELECT amenity_id FROM aliases WHERE language=? AND alias_text=?',(lang,alias)).fetchone()[0],'cctv')
    def test_bad_scope(self):
        with self.assertRaises(sqlite3.IntegrityError):self.db.execute("UPDATE amenities SET default_scope='anywhere'")
    def test_unknown_amenity(self):
        with self.assertRaises(sqlite3.IntegrityError):self.db.execute("INSERT INTO aliases VALUES ('en','unknown','does-not-exist')")
    def test_synthetic_review(self):
        self.db.executescript((ROOT/'sql/synthetic-example.sql').read_text())
        text='\n'.join(l for l in (ROOT/'sql/review.sql').read_text().splitlines() if not l.lstrip().startswith('--'))
        queries=[q.strip() for q in text.split(';') if q.strip()]
        results=[self.db.execute(q).fetchall() for q in queries]
        self.assertEqual([len(r) for r in results],[1,1,1,1])
    def test_deterministic(self):
        before=(ROOT/'sql/vocabulary.sql').read_bytes();build();self.assertEqual((ROOT/'sql/vocabulary.sql').read_bytes(),before)
    def test_csv(self):
        with (ROOT/'data/amenities.csv').open(encoding='utf8') as f:rows=list(csv.DictReader(f))
        self.assertEqual(len(rows),self.db.execute('SELECT COUNT(*) FROM amenities').fetchone()[0])
if __name__=='__main__':unittest.main()
