-- Q1 returns (name,dod)
SELECT p_b.name,
       p_a.dod
FROM   person AS p_a, person AS p_b
WHERE  p_a.name = p_b.mother
AND    p_a.dod IS NOT NULL
;

-- Q2 returns (name)
SELECT name
FROM person
WHERE gender = 'M'
AND name IS NOT NULL
AND name NOT IN (SELECT father
		 FROM person
		 WHERE father IS NOT NULL)
ORDER BY name ASC
;

-- Q3 returns (name)
SELECT name
FROM person
WHERE NOT EXISTS(
	SELECT person_other.gender
	FROM person as person_other
	WHERE person_other.gender NOT IN (
				   SELECT person_child.gender
				   FROM person as person_child
				   WHERE person_child.mother = person.name)
	)
ORDER BY name ASC
;

-- Q4 returns (name,father,mother)
SELECT DISTINCT p_first.name,p_first.father,p_first.mother
FROM person AS p_first,
     person AS p_other
WHERE p_first.father = p_other.father
AND p_first.mother = p_other.mother
AND p_first.dob <= ALL (SELECT DISTINCT p_other.dob
			FROM person AS p_other
			WHERE p_first.father = p_other.father
			AND p_other.mother = p_first.mother)
ORDER BY p_first.name ASC
;

-- Q5 returns (name,popularity)
SELECT SUBSTRING(name FROM '[a-zA-Z]+') AS name,
       COUNT(SUBSTRING(name FROM '[a-zA-Z]+')) AS popularity
FROM person AS p
WHERE SUBSTRING(name FROM '[a-zA-Z]+') <> ''
GROUP BY SUBSTRING(name FROM '[a-zA-Z]+')
HAVING COUNT(SUBSTRING(name FROM '[a-zA-Z]+')) > 1
ORDER BY popularity DESC,name
;


-- Q6 returns (name,forties,fifties,sixties)
SELECT p_parent.name as name,
       COUNT(CASE WHEN p_children.dob <= '1949-12-31' AND p_children.dob >= '1940-01-01' THEN p_children.father ELSE NULL END) AS forties,
       COUNT(CASE WHEN p_children.dob <= '1959-12-31' AND p_children.dob >= '1950-01-01' THEN p_children.father ELSE NULL END) AS fifties,
       COUNT(CASE WHEN p_children.dob <= '1969-12-31' AND p_children.dob >= '1960-01-01' THEN p_children.father ELSE NULL END) AS sixties
FROM person AS p_parent,
     person AS p_children
WHERE p_children.father = p_parent.name
OR p_children.mother = p_parent.name
GROUP BY p_parent.name
HAVING COUNT(p_parent.name = p_children.father) > 1
OR COUNT(p_parent.name = p_children.mother) > 1
ORDER BY p_parent.name
;
-- Q7 returns (father,mother,child,born)
SELECT father,
       mother,
       name AS child,
       RANK() OVER (PARTITION BY father ORDER BY dob ASC) AS born
FROM person
WHERE father IS NOT NULL
AND mother IS NOT NULL
ORDER BY father,mother,born
;

-- Q8 returns (father,mother,male)
SELECT DISTINCT father,mother,
		ROUND (100*COUNT(CASE WHEN gender = 'M' THEN name ELSE NULL END) / COUNT(name),0) AS male
FROM person
WHERE father IS NOT NULL
AND mother IS NOT NULL
GROUP BY father,mother
ORDER BY father,mother
;
