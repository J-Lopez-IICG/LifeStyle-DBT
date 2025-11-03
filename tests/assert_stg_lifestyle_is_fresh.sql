-- Esta prueba verifica que el modelo stg_lifestyle se haya ejecutado en las últimas 24 horas.
-- Falla si la marca de tiempo MÁXIMA en la columna 'loaded_at' es más antigua que 24 horas.

SELECT
    MAX(loaded_at) AS latest_load_date
FROM
    {{ ref('stg_lifestyle') }}
HAVING
    -- Falla si la fecha de carga más reciente es anterior a "hace 24 horas".
    latest_load_date < CAST({{ dbt.dateadd('hour', -24, dbt.current_timestamp()) }} AS TIMESTAMP)