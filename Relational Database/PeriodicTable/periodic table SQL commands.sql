ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;
ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;
ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;
ALTER TABLE elements ADD UNIQUE (symbol, name);
ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
ALTER TABLE elements ALTER COLUMN name SET NOT NULL;
ALTER TABLE properties ADD FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);
CREATE TABLE types();
ALTER TABLE types ADD type_id INT PRIMARY KEY;
ALTER TABLE types ADD type VARCHAR NOT NULL;
INSERT INTO types (type_id, type) VALUES (1, 'metal'), (2, 'metalloid'), (3, 'nonmetal');
ALTER TABLE properties ADD COLUMN type_id INT;
ALTER TABLE properties ADD FOREIGN KEY (type_id) REFERENCES types(type_id);

UPDATE properties
SET type_id = types.type_id
FROM types
WHERE properties.type = types.type;

/* Shorter version with aliases
# UPDATE properties
# SET type_id = t.type_id
# FROM types t
# WHERE properties.type = t.type;
*/

ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;
UPDATE elements SET symbol='He' WHERE name='Helium';
UPDATE elements SET symbol='Li' WHERE name='Lithium';
UPDATE elements SET symbol='MT' WHERE name='moTanium';
-- Float removes trailing zeroes
ALTER TABLE properties ALTER COLUMN atomic_mass SET DATA TYPE FLOAT;
INSERT INTO elements (atomic_number, symbol, name) VALUES (9, 'F', 'Fluorine'), (10, 'Ne', 'Neon');
INSERT INTO properties (atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES (9, 'nonmetal', 18.998, -220, -188.1, 3), (10, 'nonmetal', 20.18, -248.6, -246.1, 3);

DELETE FROM properties WHERE atomic_number=1000;
DELETE FROM elements WHERE atomic_number=1000;
ALTER TABLE properties DROP COLUMN type;
































