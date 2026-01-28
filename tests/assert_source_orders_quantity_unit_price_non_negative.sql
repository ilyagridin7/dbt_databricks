{{config(severity = 'warn')}}

SELECT
*
FROM
{{ source('landing','orders') }}
WHERE unit_price < 0 or quantity < 0