WITH student_base AS (
    SELECT 
        ROW_NUMBER() OVER() AS student_id,
        Course AS course,
        Gender AS gender,
        Age_at_enrollment AS age,
        Scholarship_holder AS scholarship_holder,
        Tuition_fees_up_to_date AS fees_up_to_date,
        Previous_qualification_grade AS school_grade,
        Admission_grade AS admission_grade,
        Curricular_units_1st_sem_enrolled AS units_1st_enrolled,
        Curricular_units_1st_sem_approved AS units_1st_approved,
        Curricular_units_1st_sem_grade AS grade_1st_sem,
        Curricular_units_2nd_sem_grade AS grade_2nd_sem,
        Target AS target
    FROM students_data
    WHERE Admission_grade > 0
)
SELECT 
    *,
    ROUND(CAST(units_1st_approved AS REAL) / NULLIF(units_1st_enrolled, 0) * 100, 2) AS pass_rate_1st_sem,
    ROUND(AVG(grade_2nd_sem) OVER(PARTITION BY course), 2) AS avg_course_grade
FROM student_base;
