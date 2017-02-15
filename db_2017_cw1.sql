-- Q1 returns (name,dod)
SELECT p_b.name,
			 p_a.dod
FROM 	 person AS p_a, person AS p_b
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
SELECT DISTINCT p_mom.name
FROM person AS p_chi,
		 person AS p_mom
WHERE (p_mom.name = p_chi.mother)
AND		(p_chi.gender = 'M')
INTERSECT
SELECT DISTINCT p_mom.name
FROM person AS p_chi,
		 person AS p_mom
WHERE (p_mom.name = p_chi.mother)
AND		(p_chi.gender = 'F')
ORDER BY name ASC
;

-- Q4 returns (name,father,mother)
SELECT DISTINCT p_first.name, p_first.dob, p_first.father, p_first.mother
FROM person AS p_first,
		 person AS p_other
WHERE p_first.father IS NOT NULL
AND p_first.mother IS NOT NULL
AND p_first.father = p_other.father
AND p_first.mother = p_other.mother
--AND p_first.dob > p_other.dob
--AND p_first.dob > ALL(SELECT p_other.dob
--											FROM person AS p_other
--											WHERE p_first.father = p_other.father
--											AND p_first.mother = p_other.mother)
ORDER BY p_first.father ASC
;

-- Q5 returns (name,popularity)

;

-- Q6 returns (name,forties,fifties,sixties)

;


-- Q7 returns (father,mother,child,born)

;

-- Q8 returns (father,mother,male)

;
