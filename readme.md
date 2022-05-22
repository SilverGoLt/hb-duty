
# hb-duty

A simple duty system for ESX Jobs

## Dependencies
- ESX Legacy
- ox_lib

## Contributors
- Haroki
- Boost

## SQL Query
```sql
USE `es_extended`;

INSERT INTO `jobs` (name, label) VALUES
	('offduty', 'Off-Duty')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('offduty', 0, 'offduty', 'Off-Duty', 0, '{}', '{}')
;
```


