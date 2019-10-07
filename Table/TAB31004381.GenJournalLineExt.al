tableextension 81 GenJournalLine extends "Gen. Journal Line"
{
    fields
    {
        field(212; "Transaction No."; Code[30])
        {
            DataClassification = SystemMetadata;
            TableRelation = Entity;
        }
        field(214; "Bill No."; Code[30])
        {
            DataClassification = SystemMetadata;
        }
        field(216; "Acc: cash-flow code"; Code[30])
        {
            DataClassification = SystemMetadata;
        }

        field(218; "DRF Code"; Code[30])
        {
            DataClassification = SystemMetadata;
        }
        field(220; "UE Aquisition Not Accep."; Code[30])
        {
            DataClassification = SystemMetadata;
        }
        field(222; "Not in VAT Report"; Code[30])
        {
            DataClassification = SystemMetadata;
        }
        field(224; "Bal: cash-flow code"; Code[30])
        {
            DataClassification = SystemMetadata;
        }
        field(226; "Bal. DRF Code"; Code[30])
        {
            DataClassification = SystemMetadata;
        }
        field(228; "Applies-to Bill No."; Code[30])
        {
            DataClassification = SystemMetadata;
        }

    }

}