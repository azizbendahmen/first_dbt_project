{% set inc_flag=1 %}
{% set last_load=4 %}

{% set col=["sales_id", "date_sk" , "gross_amount"]%}

select 
    {% for c in col %}
        {{ c }} 
        {% if not loop.last %}, {% endif %}
    {% endfor %}
from 
    {{ ref("bronze-sales")}}

{% if inc_flag == 1 %}
where
    load_date > '{{ last_load }}'
{% endif %}