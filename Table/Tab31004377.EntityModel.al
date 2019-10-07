table 31004377 "Entity Model"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*]</LMS>

    Caption = 'Entity Model';
    Description = 'ID:ENTITY.00.01.01.00';
    LookupPageID = 31004421;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Customer,Vendor';
            OptionMembers = Customer,Vendor;
        }
        field(3; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(10; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = IF (Type = CONST(Customer)) "Customer Posting Group".Code;

            trigger OnValidate()
            var
                lRecEntity: Record 31004376;
                lRecCustomer: Record 18;
            begin
                IF (Type <> Type::Customer) THEN
                    TESTFIELD("Customer Posting Group", '');

                // Change Customer card also
                IF Type = Type::Customer THEN BEGIN
                    CLEAR(lRecEntity);
                    lRecEntity.SETRANGE("Customer Model", Code);
                    lRecEntity.SETFILTER("Customer No.", '<>%1', '');
                    IF lRecEntity.FINDSET() THEN
                        REPEAT
                            CLEAR(lRecCustomer);
                            lRecCustomer.GET(lRecEntity."Customer No.");
                            lRecCustomer.VALIDATE("Customer Posting Group", "Customer Posting Group");
                            lRecCustomer.MODIFY();
                        UNTIL lRecEntity.NEXT() = 0;
                END;
            end;
        }
        field(11; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = IF (Type = CONST(Vendor)) "Vendor Posting Group".Code;

            trigger OnValidate()
            var
                lRecEntity: Record 31004376;
                lRecVendor: Record 23;
            begin
                IF (Type <> Type::Vendor) THEN
                    TESTFIELD("Vendor Posting Group", '');

                // Change Vendor card also
                IF Type = Type::Vendor THEN BEGIN
                    CLEAR(lRecEntity);
                    lRecEntity.SETRANGE("Vendor Model", Code);
                    lRecEntity.SETFILTER("Vendor No.", '<>%1', '');
                    IF lRecEntity.FINDSET() THEN
                        REPEAT
                            CLEAR(lRecVendor);
                            lRecVendor.GET(lRecEntity."Vendor No.");
                            lRecVendor.VALIDATE("Vendor Posting Group", "Vendor Posting Group");
                            lRecVendor.MODIFY();
                        UNTIL lRecEntity.NEXT() = 0;
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

