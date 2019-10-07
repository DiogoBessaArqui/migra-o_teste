table 31004378 "Entity Association"
{
    // version FinPack_ENT1.0

    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*]<Comment> New Table </Comment>
    // //[*]</LMS>

    Caption = 'Entity Association';

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            NotBlank = true;
            OptionCaption = ' ,Customer,Vendor';
            OptionMembers = " ",Customer,Vendor;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST(Customer)) "Customer"."No." WHERE("VAT Registration No." = FIELD("Entity VAT Registration No."))
            ELSE
            IF (Type = CONST(Vendor)) "Vendor"."No." WHERE("VAT Registration No." = FIELD("Entity VAT Registration No."));

            trigger OnValidate()
            begin
                CLEAR(gRecCustomer);
                CLEAR(gRecVendor);
                IF Type = Type::Customer THEN BEGIN
                    IF gRecCustomer.GET("No.") THEN BEGIN
                        gRecCustomer.CALCFIELDS("Balance (LCY)");
                        Name := gRecCustomer.Name;
                        "VAT Registration No." := gRecCustomer."VAT Registration No.";
                        "Customer No." := "No.";
                    END
                END ELSE
                    IF Type = Type::Vendor THEN
                        IF gRecVendor.GET("No.") THEN BEGIN
                            gRecVendor.CALCFIELDS("Balance (LCY)");
                            Name := gRecVendor.Name;
                            "VAT Registration No." := gRecVendor."VAT Registration No.";
                            "Vendor No." := "No.";
                        END;
            end;
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(4; "VAT Registration No."; Text[30])
        {
            Caption = 'VAT Registration No.';
            Editable = false;
        }
        field(5; "Customer Balance (LCY)"; Decimal)
        {
            CalcFormula = Sum ("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("Customer No.")));
            Caption = 'Customer Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Entity VAT Registration No."; Text[30])
        {
            Caption = 'Entity VAT Registration No.';
            Editable = false;
        }
        field(7; "Vendor Balance (LCY)"; Decimal)
        {
            CalcFormula = - Sum ("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("Vendor No.")));
            Caption = 'Vendor Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Description = 'Used for Customer Balance (LCY)';
        }
        field(11; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            Description = 'Used for Vendor Balance (LCY)';
        }
    }

    keys
    {
        key(Key1; "Entity VAT Registration No.", "No.", Type)
        {
        }
        key(Key2; Type)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CLEAR(gRecCustomer);
        CLEAR(gRecVendor);
        IF Type = Type::Customer THEN BEGIN
            IF gRecCustomer.GET("No.") THEN BEGIN
                gRecCustomer."Entity No." := '';
                gRecCustomer.MODIFY();
            END
        END ELSE
            IF Type = Type::Vendor THEN
                IF gRecVendor.GET("No.") THEN BEGIN
                    gRecVendor."Entity No." := '';
                    gRecVendor.MODIFY();
                END

    end;

    trigger OnInsert()
    begin
        CLEAR(gRecEntity);
        CLEAR(gRecCustomer);
        CLEAR(gRecVendor);
        gRecEntity.SETRANGE("VAT Registration No.", "VAT Registration No.");
        IF Type = Type::Customer THEN BEGIN
            IF gRecEntity.FINDFIRST() THEN
                IF gRecCustomer.GET("No.") THEN BEGIN
                    gRecCustomer."Entity No." := gRecEntity."No.";
                    gRecCustomer.MODIFY();
                END

        END ELSE
            IF Type = Type::Vendor THEN
                IF gRecEntity.FINDFIRST() THEN
                    IF gRecVendor.GET("No.") THEN BEGIN
                        gRecVendor."Entity No." := gRecEntity."No.";
                        gRecVendor.MODIFY();
                    END


    end;

    var
        gRecCustomer: Record 18;
        gRecVendor: Record 23;
        gRecEntity: Record 31004376;
}

