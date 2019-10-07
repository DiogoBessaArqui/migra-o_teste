tableextension 379 DetailedCustLedgEntry extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        field(212; "Excluded from calculation"; Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(213; "Customer Posting Group"; Code[30])
        {
            DataClassification = SystemMetadata;
        }

    }

}