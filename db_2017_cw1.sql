-- Q1 returns (name,dod)
SELECT p_b.name,
			 p_a.dod
FROM 	 person p_a, person p_b
WHERE  p_a.name = p_b.mother
AND		 p_a.dod IS NOT NULL
ORDER BY p_b.name ASC
;

-- Q2 returns (name)
SELECT name
FROM person
WHERE (father IS NOT NULL)
AND (gender = 'M')
ORDER BY name ASC
;

-- Q3 returns (name)
SELECT p_a.name
FROM person p_a, person p_b
WHERE 
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
