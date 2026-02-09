-- ============================================================================
-- TEST-SKRIPT FOR OPPGAVESETT 1.4: Databasemodellering og implementering
-- ============================================================================

-- Kjør med: docker-compose exec postgres psql -h -U admin -d data1500_db -f test-scripts/oppgave4_losning.sql
SELECT beskjed_id, datetime_dato, innhold
 FROM beskjed 
 WHERE klasserom_id = 1 
 ORDER BY datetime_dato DESC 
 LIMIT 3;




SELECT bruker.bruker_id, bruker.brukernavn
FROM bruker 
JOIN medlemskap m ON bruker.bruker_id = medlemskap.bruker_id
WHERE medlemskap.gruppe_id = 1;


SELECT COUNT(*) AS antall_gruppe
FROM gruppe;

-- En test SQL-spørring mot metadata i PostgreSQL
select nspname as schema_name from pg_catalog.pg_namespace;
