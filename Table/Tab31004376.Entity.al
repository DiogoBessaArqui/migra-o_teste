table 31004376 "Entity"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Table </Comment>
    // //[*]</LMS>

    Caption = 'Entity';
    Description = 'ID:ENTITY.00.01.01.00';
    LookupPageID = 31004419;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(4; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(5; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(6; "Postal Code"; Code[20])
        {
            Caption = 'Postal Code';
            TableRelation = IF ("Country Code" = CONST()) "Post Code"
            ELSE
            IF ("Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country Code"));

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                PostCode.ValidatePostCode(City, "Postal Code", County, "Country Code", (CurrFieldNo <> 0) AND GUIALLOWED());
            end;
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country Code" = CONST()) "Post Code".City
            ELSE
            IF ("Country Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country Code"));

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                PostCode.ValidateCity(City, "Postal Code", County, "Country Code", (CurrFieldNo <> 0) AND GUIALLOWED());
            end;
        }
        field(8; County; Text[30])
        {
            Caption = 'County';
        }
        field(9; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(20; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = "Customer"."No.";

            trigger OnLookup()
            var
                lRecCustomer: Record 18;

                lRecEntity: Record 31004376;
                lRecCustomer2: Record 18;
                lpgCustomer: Page 22;

            begin
                lRecCustomer.TESTFIELD("Gen. Bus. Posting Group");
                lRecCustomer.TESTFIELD("VAT Bus. Posting Group");

                CLEAR(lRecCustomer);
                lRecCustomer.FILTERGROUP(10);
                IF "Customer Model" <> '' THEN BEGIN
                    lRecEntityModel.GET("Customer Model");
                    lRecCustomer.SETRANGE("Customer Posting Group", lRecEntityModel."Customer Posting Group");
                END;
                IF "Gen. Bus. Posting Group" <> '' THEN
                    lRecCustomer.SETRANGE("Gen. Bus. Posting Group", "Gen. Bus. Posting Group");
                IF "VAT Bus. Posting Group" <> '' THEN
                    lRecCustomer.SETRANGE("VAT Bus. Posting Group", "VAT Bus. Posting Group");
                IF lRecCustomer.FINDSET() THEN
                    REPEAT
                        CLEAR(lRecEntity);
                        lRecEntity.SETRANGE("Customer No.", lRecCustomer."No.");
                        IF lRecEntity.FINDFIRST() THEN BEGIN
                            IF lRecEntity."No." = "No." THEN
                                lRecCustomer.MARK := TRUE;
                        END
                        ELSE
                            lRecCustomer.MARK := TRUE;
                    UNTIL lRecCustomer.NEXT() = 0;

                lRecCustomer.MARKEDONLY(TRUE);
                lRecCustomer.FILTERGROUP(0);

                CLEAR(lpgCustomer);
                lpgCustomer.LOOKUPMODE := TRUE;
                lpgCustomer.SETTABLEVIEW(lRecCustomer);

                IF lRecCustomer2.GET("Customer No.") THEN
                    lpgCustomer.SETRECORD(lRecCustomer2);

                IF lpgCustomer.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                    lpgCustomer.GETRECORD(lRecCustomer);
                    VALIDATE("Customer No.", lRecCustomer."No.");
                    IF "Gen. Bus. Posting Group" = '' THEN
                        VALIDATE("Gen. Bus. Posting Group", lRecCustomer."Gen. Bus. Posting Group");
                    IF "VAT Bus. Posting Group" = '' THEN
                        VALIDATE("VAT Bus. Posting Group", lRecCustomer."VAT Bus. Posting Group");
                END;
            end;

            trigger OnValidate()
            var
                lRecCustomer: Record 18;

                lRecEntity: Record 31004376;
            begin
                IF ("Customer No." <> '') AND ("Customer No." <> xRec."Customer No.") THEN BEGIN
                    CLEAR(lRecCustomer);
                    lRecCustomer.GET("Customer No.");
                    IF "Customer Model" <> '' THEN BEGIN
                        lRecEntityModel.GET("Customer Model");
                        lRecCustomer.TESTFIELD("Customer Posting Group", lRecEntityModel."Customer Posting Group");
                    END;

                    CLEAR(lRecEntity);
                    lRecEntity.SETFILTER("No.", '<>%1', "No.");
                    lRecEntity.SETRANGE("Customer No.", "Customer No.");
                    IF lRecEntity.FINDFIRST() THEN
                        ERROR(Text1110001Lbl, "Customer No.", lRecEntity."No.");

                    lRecCustomer."Entity No." := "No.";
                    lRecCustomer.MODIFY();
                END;

                IF (xRec."Customer No." <> '') AND ("Customer No." <> xRec."Customer No.") THEN
                    CLEAR(lRecCustomer);
                IF lRecCustomer.GET(xRec."Customer No.") THEN BEGIN
                    lRecCustomer."Entity No." := '';
                    lRecCustomer.MODIFY();
                END;

                CalcBalance();
            end;
        }
        field(21; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = "Vendor"."No.";

            trigger OnLookup()
            var
                lRecVendor: Record 23;

                lRecEntity: Record 31004376;
                lRecVendor2: Record 23;
                lPgVendor: Page 27;

            begin
                lRecVendor.TESTFIELD("Gen. Bus. Posting Group");
                lRecVendor.TESTFIELD("VAT Bus. Posting Group");

                CLEAR(lRecVendor);
                lRecVendor.FILTERGROUP(10);
                IF "Vendor Model" <> '' THEN BEGIN
                    lRecEntityModel.GET("Vendor Model");
                    lRecVendor.SETRANGE("Vendor Posting Group", lRecEntityModel."Vendor Posting Group");
                END;
                IF "Gen. Bus. Posting Group" <> '' THEN
                    lRecVendor.SETRANGE("Gen. Bus. Posting Group", "Gen. Bus. Posting Group");
                IF "VAT Bus. Posting Group" <> '' THEN
                    lRecVendor.SETRANGE("VAT Bus. Posting Group", "VAT Bus. Posting Group");
                IF lRecVendor.FINDSET() THEN
                    REPEAT
                        CLEAR(lRecEntity);
                        lRecEntity.SETRANGE("Vendor No.", lRecVendor."No.");
                        IF lRecEntity.FINDFIRST() THEN BEGIN
                            IF lRecEntity."No." = "No." THEN
                                lRecVendor.MARK := TRUE;
                        END
                        ELSE
                            lRecVendor.MARK := TRUE;
                    UNTIL lRecVendor.NEXT() = 0;

                lRecVendor.MARKEDONLY(TRUE);
                lRecVendor.FILTERGROUP(0);

                CLEAR(lPgVendor);
                lPgVendor.LOOKUPMODE := TRUE;
                lPgVendor.SETTABLEVIEW(lRecVendor);

                IF lRecVendor2.GET("Vendor No.") THEN
                    lPgVendor.SETRECORD(lRecVendor2);

                IF lPgVendor.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                    lPgVendor.GETRECORD(lRecVendor);
                    VALIDATE("Vendor No.", lRecVendor."No.");
                    IF "Gen. Bus. Posting Group" = '' THEN
                        VALIDATE("Gen. Bus. Posting Group", lRecVendor."Gen. Bus. Posting Group");
                    IF "VAT Bus. Posting Group" = '' THEN
                        VALIDATE("VAT Bus. Posting Group", lRecVendor."VAT Bus. Posting Group");
                END;
            end;

            trigger OnValidate()
            var
                lRecVendor: Record 23;
                lRecEntity: Record 31004376;

            begin
                IF ("Vendor No." <> '') AND ("Vendor No." <> xRec."Vendor No.") THEN BEGIN

                    CLEAR(lRecVendor);
                    lRecVendor.GET("Vendor No.");
                    IF "Vendor Model" <> '' THEN BEGIN
                        lRecEntityModel.GET("Vendor Model");
                        lRecVendor.TESTFIELD("Vendor Posting Group", lRecEntityModel."Vendor Posting Group");
                    END;

                    CLEAR(lRecEntity);
                    lRecEntity.SETFILTER("No.", '<>%1', "No.");
                    lRecEntity.SETRANGE("Vendor No.", "Vendor No.");
                    IF lRecEntity.FINDFIRST() THEN
                        ERROR(Text1110002Lbl, "Vendor No.", lRecEntity."No.");

                    lRecVendor."Entity No." := "No.";
                    lRecVendor.MODIFY();
                END;

                IF (xRec."Vendor No." <> '') AND ("Vendor No." <> xRec."Vendor No.") THEN
                    CLEAR(lRecVendor);
                IF lRecVendor.GET(xRec."Vendor No.") THEN BEGIN
                    lRecVendor."Entity No." := '';
                    lRecVendor.MODIFY();
                END;

                CalcBalance();
            end;
        }
        field(30; "Customer Balance (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("Customer No."), "Posting Date" = FIELD("Date Filter")));
            Caption = 'Customer Balance (LCY)';
        }
        field(31; "Vendor Balance (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum ("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("Vendor No."), "Posting Date" = FIELD("Date Filter")));
            Caption = 'Vendor Balance (LCY)';
        }
        field(32; "Balance (LCY)"; Decimal)
        {
            Caption = 'Balance (LCY)';
        }
        field(40; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group".Code;

            trigger OnValidate()
            begin
                ValidateField();
            end;
        }
        field(41; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group".Code;

            trigger OnValidate()
            begin
                ValidateField();
            end;
        }
        field(50; "Customer Model"; Code[20])
        {
            Caption = 'Customer Model';
            TableRelation = "Entity Model".Code WHERE(Type = CONST(Customer));

            trigger OnValidate()
            begin
                ValidateField();
            end;
        }
        field(51; "Vendor Model"; Code[20])
        {
            Caption = 'Vendor Model';
            TableRelation = "Entity Model".Code WHERE(Type = CONST(Vendor));

            trigger OnValidate()
            begin
                ValidateField();
            end;
        }
        field(60; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms".Code;
        }
        field(61; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method".Code;
        }
        field(70; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
        }
        field(71; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language.Code;
        }
        field(72; "VAT Registration No."; Text[30])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            begin
            end;
        }
        field(100; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50000; "Entity Customer Balance (LCY)"; Decimal)
        {
            Caption = 'Entity Customer Balance (LCY)';
            Editable = false;
            FieldClass = Normal;
        }
        field(50001; "Entity Vendor Balance (LCY)"; Decimal)
        {
            Caption = 'Entity Vendor Balance (LCY)';
            Editable = false;
            FieldClass = Normal;
        }
        field(50002; "Entity Balance (LCY)"; Decimal)
        {
            Caption = 'Entity Balance (LCY)';
            Editable = false;
        }
        field(50003; "Customer No. EntityAss"; Code[20])
        {
            Caption = 'Customer No.';

            trigger OnLookup()
            var
                lRecEntityAss: Record 31004378;
            begin
                CLEAR(lRecEntityAss);
                lRecEntityAss.SETRANGE("Entity VAT Registration No.", "VAT Registration No.");
                lRecEntityAss.SETRANGE(Type, lRecEntityAss.Type::Customer);
                IF PAGE.RUNMODAL(PAGE::"Entity Association List", lRecEntityAss) = ACTION::LookupOK THEN
                    "Customer No. EntityAss" := lRecEntityAss."Customer No.";
            end;
        }
        field(50004; "Vendor No. EntityAss"; Code[20])
        {
            Caption = 'Vendor No.';

            trigger OnLookup()
            var
                lRecEntityAss: Record 31004378;
            begin
                CLEAR(lRecEntityAss);
                lRecEntityAss.SETRANGE("Entity VAT Registration No.", "VAT Registration No.");
                lRecEntityAss.SETRANGE(Type, lRecEntityAss.Type::Vendor);
                IF PAGE.RUNMODAL(PAGE::"Entity Association List", lRecEntityAss) = ACTION::LookupOK THEN
                    "Vendor No. EntityAss" := lRecEntityAss."Vendor No.";
            end;
        }
        field(50005; "CCC Bank Account No."; Text[250])
        {
            Caption = 'CCC Bank Account No.';
            Numeric = true;

            trigger OnValidate()
            begin
                "CCC Bank Account No." := PrePadString("CCC Bank Account No.", MAXSTRLEN("CCC Bank Account No."));
                BuildCCC();
            end;
        }
        field(50006; "CCC Bank Branch No."; Text[250])
        {
            Caption = 'CCC Bank Branch No.';
            Numeric = true;

            trigger OnValidate()
            begin
                "CCC Bank Branch No." := PrePadString("CCC Bank Branch No.", MAXSTRLEN("CCC Bank Branch No."));
                BuildCCC();
            end;
        }
        field(50007; "CCC Bank No."; Text[250])
        {
            Caption = 'CCC Bank No.';
            Numeric = true;

            trigger OnValidate()
            begin
                "CCC Bank No." := PrePadString("CCC Bank No.", MAXSTRLEN("CCC Bank No."));
                BuildCCC();
            end;
        }
        field(50008; "CCC Control Digits"; Text[250])
        {
            Caption = 'CCC Control Digits';
            Numeric = true;

            trigger OnValidate()
            begin
                "CCC Control Digits" := PrePadString("CCC Control Digits", MAXSTRLEN("CCC Control Digits"));
                BuildCCC();
            end;
        }
        field(50009; "CCC No."; Text[21])
        {
            Caption = 'CCC No.';
            Numeric = true;

            trigger OnValidate()
            begin
                "CCC Bank No." := COPYSTR("CCC No.", 1, 4);
                "CCC Bank Branch No." := COPYSTR("CCC No.", 5, 4);
                "CCC Bank Account No." := COPYSTR("CCC No.", 9, 11);
                "CCC Control Digits" := COPYSTR("CCC No.", 20, 2);
            end;
        }
        field(50010; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';

            trigger OnValidate()
            begin
                TESTFIELD("CCC Bank Account No.", '');
            end;
        }
        field(50011; IBAN; Code[50])
        {
            Caption = 'IBAN';

            trigger OnValidate()
            var
                CompanyInfo: Record 79;
            begin
                CompanyInfo.CheckIBAN(IBAN);
            end;
        }
        field(50012; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(50013; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(50014; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(50015; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(50016; "Bank Account Code"; Code[10])
        {
            Caption = 'Bank Account Code';
        }
        field(50017; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code';
        }
        field(50018; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
        }
        field(50019; "Bank Address"; Text[50])
        {
            Caption = 'Bank Address';
        }
        field(50020; "Bank City"; Text[30])
        {
            Caption = 'Bank City';
            TableRelation = IF ("Bank Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Bank Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Bank Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                PostCode.ValidateCity(City, "Bank Post Code", County, "Bank Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED());
            end;
        }
        field(50021; "Bank Post Code"; Code[20])
        {
            Caption = 'Bank Post Code';
            TableRelation = IF ("Bank Country/Region Code" = CONST()) "Post Code"
            ELSE
            IF ("Bank Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Bank Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Bank Post Code", County, "Bank Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED());
            end;
        }
        field(50022; "Bank Country/Region Code"; Code[10])
        {
            Caption = 'Bank Country/Region Code';
            TableRelation = "Country/Region";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lCduNoSeriesMgt: Codeunit 396;
    begin
        // Check if the "no." is filled, and fill it based on Setup Nos Series
        IF "No." = '' THEN
            IF "No. Series" = '' THEN BEGIN
                gRecEntitySetup.GET();
                gRecEntitySetup.TESTFIELD("Entity Series Nos.");

                CLEAR(lCduNoSeriesMgt);
                lCduNoSeriesMgt.InitSeries(gRecEntitySetup."Entity Series Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            END
            ELSE BEGIN
                CLEAR(lCduNoSeriesMgt);
                lCduNoSeriesMgt.InitSeries(xRec."No. Series", xRec."No. Series", 0D, "No.", "No. Series");
            END;

    end;

    var
        gRecEntitySetup: Record 31004375;
        PostCode: Record 225;
        lRecEntityModel: Record 31004377;
        Text1110001Lbl: Label 'Customer %1 is already associated with Entity %2.';
        Text1110002Lbl: Label 'Vendor %1 is already associated with Entity %2.';
        Text1110004Lbl: Label 'The field %1 must be empty.';

    procedure AssistEdit(OldEnt: Record 31004376): Boolean
    var
        lRecEntity: Record 31004376;
        lCduNoSeriesMgt: Codeunit 396;
    begin
        // Assist Edit

        WITH lRecEntity DO BEGIN
            lRecEntity := Rec;
            gRecEntitySetup.GET();
            gRecEntitySetup.TESTFIELD("Entity Series Nos.");

            CLEAR(lCduNoSeriesMgt);
            IF lCduNoSeriesMgt.SelectSeries(gRecEntitySetup."Entity Series Nos.", OldEnt."No. Series", "No. Series") THEN BEGIN
                lCduNoSeriesMgt.SetSeries("No.");
                Rec := lRecEntity;
                EXIT(TRUE);
            END;
        END;
    end;

    procedure CalcBalance()
    var
        lRecEntityAssociation: Record 31004378;
    begin
        CLEAR(lRecEntityAssociation);
        lRecEntityAssociation.SETRANGE("VAT Registration No.", "VAT Registration No.");
        "Entity Customer Balance (LCY)" := 0;
        "Entity Vendor Balance (LCY)" := 0;

        IF lRecEntityAssociation.FINDSET() THEN
            REPEAT
                lRecEntityAssociation.CALCFIELDS("Customer Balance (LCY)", "Vendor Balance (LCY)");
                "Entity Customer Balance (LCY)" += lRecEntityAssociation."Customer Balance (LCY)";
                "Entity Vendor Balance (LCY)" += lRecEntityAssociation."Vendor Balance (LCY)";
            UNTIL lRecEntityAssociation.NEXT() = 0;

        "Entity Balance (LCY)" := "Entity Customer Balance (LCY)" - "Entity Vendor Balance (LCY)";
    end;

    procedure ValidateField()
    begin
        // Validate Field
        CASE CurrFieldNo OF
            FIELDNO("Gen. Bus. Posting Group"):
                BEGIN
                    IF "Customer No." <> '' THEN
                        ERROR(Text1110004Lbl, FIELDCAPTION("Customer No."));
                    IF "Vendor No." <> '' THEN
                        ERROR(Text1110004Lbl, FIELDCAPTION("Vendor No."));
                END;
            FIELDNO("VAT Bus. Posting Group"):
                BEGIN
                    IF "Customer No." <> '' THEN
                        ERROR(Text1110004Lbl, FIELDCAPTION("Customer No."));
                    IF "Vendor No." <> '' THEN
                        ERROR(Text1110004Lbl, FIELDCAPTION("Vendor No."));
                END;
            FIELDNO("Customer Model"):

                IF "Customer No." <> '' THEN
                    ERROR(Text1110004Lbl, FIELDCAPTION("Customer No."));

            FIELDNO("Vendor Model"):

                IF "Vendor No." <> '' THEN
                    ERROR(Text1110004Lbl, FIELDCAPTION("Vendor No."));

        END;
    end;

    procedure BuildCCC()
    begin
        "CCC No." := "CCC Bank No." + "CCC Bank Branch No." + "CCC Bank Account No." + "CCC Control Digits";
        IF "CCC No." <> '' THEN
            TESTFIELD("Bank Account No.", '');
    end;

    procedure PrePadString(InString: Text[250]; MaxLen: Integer): Text[250]
    begin
        EXIT(PADSTR('', MaxLen - STRLEN(InString), '0') + InString);
    end;
}

