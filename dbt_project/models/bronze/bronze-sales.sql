SELECT 
    *
from    
    {{ source('source', 'fact_sales') }}