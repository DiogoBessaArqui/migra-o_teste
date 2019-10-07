tableextension 31004380 CustomerEXT extends Customer
{
    fields
    {
        field(500; "Entity No."; Code[30])
        {
            DataClassification = SystemMetadata;
            TableRelation = Entity;
        }
        field(522; "Payment Days Code"; Code[30])
        {
            DataClassification = SystemMetadata;
        }
        field(523; "Non-Paymt. Periods Code"; Code[30])
        {
            DataClassification = SystemMetadata;
        }
    }

}