-- Q1 returns (name,dod)
SELECT person_b.name AS person_b_name,
			 person_b.mom AS person_b_mom,
			 person_a.dod AS person_a_dod,
			 person_a.name AS person_a_name
FROM person AS person_a
		 JOIN person AS person_b
		 ON person_a_name = person_b_mom
		 AND person_a_dod is not Null
;

-- Q2 returns (name)
SELECT name
FROM person
WHERE (father is not NULL)
AND (gender = 'M')
;

-- Q3 returns (name)

;

-- Q4 returns (name,father,mother)

;

-- Q5 returns (name,popularity)

;

-- Q6 returns (name,forties,fifties,sixties)

;


-- Q7 returns (father,mother,child,born)

;

-- Q8 returns (father,mother,male)

;
