 {# Project Subscription Descriptions #}

 {% macro convertBoolean(stringBool) -%}
    CASE WHEN store_and_fwd_flag='N' THEN 'false'
        ELSE
            CASE WHEN store_and_fwd_flag='Y' THEN 'true'
                ELSE NULL END
        END
{%- endmacro %}
