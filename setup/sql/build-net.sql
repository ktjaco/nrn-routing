ALTER TABLE edges ADD source INT4;

ALTER TABLE edges ADD target INT4;

ALTER TABLE edges ALTER COLUMN the_geom TYPE geometry(LineString, 4326) USING ST_Force2D(the_geom);

SELECT pgr_nodeNetwork('edges', 0.00001);

SELECT pgr_createTopology('edges_noded', 0.00001);

ALTER TABLE edges_noded ADD COLUMN name VARCHAR, ADD COLUMN type VARCHAR, ADD COLUMN dir VARCHAR;

UPDATE edges_noded AS new SET name = old.l_stname_c, type=old.roadclass, dir = old.trafficdir FROM edges AS old WHERE new.old_id = old.id;
