"""Generate deterministic SQL/CSV from the authored bilingual vocabulary."""
import csv,json,pathlib,sqlite3
ROOT=pathlib.Path(__file__).resolve().parents[1]
def build():
    terms=json.loads((ROOT/'data/terms.json').read_text(encoding='utf8'))
    ids=set();aliases=set()
    for t in terms:
        assert t['id'] not in ids;ids.add(t['id'])
        assert t['scope'] in {'unit','building','site','service'}
        for lang in ('en','ru'):
            for alias in [t[lang],*t.get(lang+'_aliases',[])]:
                k=(lang,alias.casefold())
                assert k not in aliases,('ambiguous alias',k);aliases.add(k)
    ddl=(ROOT/'sql/schema.sql').read_text()
    def q(s):return "'"+s.replace("'","''")+"'"
    lines=[ddl]
    for t in terms:
        lines.append('INSERT INTO amenities (amenity_id,category,default_scope,label_en,label_ru,definition,review_note) VALUES ('+', '.join(q(t[k]) for k in ['id','category','scope','en','ru','definition','note'])+');')
        for lang in ('en','ru'):
            for alias in [t[lang],*t.get(lang+'_aliases',[])]:
                lines.append('INSERT INTO aliases (language,alias_text,amenity_id) VALUES ('+', '.join(q(s) for s in (lang,alias,t['id']))+');')
    sql='\n'.join(lines)+'\n'
    (ROOT/'sql/vocabulary.sql').write_text(sql,encoding='utf8')
    for name,fields,rows in [('amenities',['amenity_id','category','default_scope','label_en','label_ru','definition','review_note'],[[t[k] for k in ['id','category','scope','en','ru','definition','note']] for t in terms]),('aliases',['language','alias_text','amenity_id'],[[lang,alias,t['id']] for t in terms for lang in ('en','ru') for alias in [t[lang],*t.get(lang+'_aliases',[])]])]:
        with (ROOT/'data'/f'{name}.csv').open('w',encoding='utf8',newline='') as f:
            w=csv.writer(f,lineterminator='\n');w.writerow(fields);w.writerows(rows)
    print(len(terms),'terms,',len(aliases),'unambiguous aliases')
    return sql
if __name__=='__main__':build()
