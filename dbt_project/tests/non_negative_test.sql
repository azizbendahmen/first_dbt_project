select *
from
    {{ref('bronze-sales')}}
where
    gross_amount < 0 and net_amount < 0