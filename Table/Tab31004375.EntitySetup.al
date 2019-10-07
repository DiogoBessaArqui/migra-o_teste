table 31004375 "Entity Setup"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*]</LMS>

    Caption = 'Entity Setup';
    Description = 'ID:ENTITY.00.01.01.00';

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            Caption = 'Primary Key';
        }
        field(2; "Entity Series Nos."; Code[10])
        {
            Caption = 'Entity Series Nos.';
            TableRelation = "No. Series".Code;
        }
        field(3; "Entity Journal Template"; Code[10])
        {
            Caption = 'Entity Journal Template';
            TableRelation = "Gen. Journal Template".Name WHERE(Type = FILTER(General));
        }
        field(4; "Entity Journal Batch"; Code[20])
        {
            Caption = 'Entity Journal Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Entity Journal Template"));

            trigger OnLookup()
            var
                lRecGenJnlBatch: Record 232;
            begin
                CLEAR(lRecGenJnlBatch);
                lRecGenJnlBatch."Journal Template Name" := "Entity Journal Template";
                lRecGenJnlBatch.FILTERGROUP(2);
                lRecGenJnlBatch.SETRANGE("Journal Template Name", lRecGenJnlBatch."Journal Template Name");
                lRecGenJnlBatch.FILTERGROUP(0);
                IF PAGE.RUNMODAL(0, lRecGenJnlBatch) = ACTION::LookupOK THEN
                    "Entity Journal Batch" := lRecGenJnlBatch.Name;

            end;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

