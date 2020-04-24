ALTER TABLE edges_noded ADD COLUMN distance FLOAT8, ADD COLUMN rcost FLOAT8;

UPDATE edges_noded SET distance = ST_Length(ST_Transform(the_geom, 4326)::geography) / 1000;

UPDATE edges_noded SET rcost = ST_Length(ST_Transform(the_geom, 4326)::geography) / 1000;

UPDATE edges_noded SET rcost = rcost + 1000000 WHERE dir = 'Opposite direction' or dir = 'Same direction';

DELETE FROM edges_noded WHERE source IS NULL;

SELECT * FROM pgr_dijkstra('SELECT id, source, target, distance AS cost FROM edges_noded', 1, 9, false);
