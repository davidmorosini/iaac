WITH enumerated_registers AS(
    SELECT
        id as _id,
        company_id,
        bank_account_id,
        transfer_enabled,
        automatic_anticipation_enabled,
        automatic_anticipation_type,
        allow_inter_recipient_transfer,
        status,
        legal_name,
        ROW_NUMBER() OVER(PARTITION BY id ORDER BY updated_at DESC ) AS row_no
    FROM
        `<PROJECT_ID>.<DATASET>.<TABLE>` t
)
SELECT
    * EXCEPT (row_no)
FROM
    enumerated_registers
WHERE
    row_no = 1;
