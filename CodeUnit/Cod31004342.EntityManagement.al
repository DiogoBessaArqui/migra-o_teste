codeunit 31004342 "Entity Management"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New CodeUnit </Comment>
    // //[*]</LMS>

    Permissions = TableData 21 = imd,
                  TableData 25 = imd;

    trigger OnRun()
    begin
    end;

    var
        Text1110001Lbl: Label 'You must choose a Bank Account to register the diference.';
        Text1110002Lbl: Label 'You must select the entries to Apply.';
        Text1110004Lbl: Label 'The Entries must not have the same signal.';

    procedure CreateCustomer(p_Entity: Record 31004376; p_BoolShowCcust: Boolean)
    var
        lRecCustomer: Record 18;
        lRecSalesSetup: Record 311;
        lRecEntityModel: Record 31004377;
        lRecEntityAssociation: Record 31004378;
        lpgCustomer: Page 21;
    begin
        // Create new customer from the entity
        //------------------------------------

        // Check if the Entity already has a customer
        //-------------------------------------------
        p_Entity.TESTFIELD("Gen. Bus. Posting Group");
        p_Entity.TESTFIELD("VAT Bus. Posting Group");
        p_Entity.TESTFIELD("Customer Model");

        lRecSalesSetup.GET();
        lRecSalesSetup.TESTFIELD("Customer Nos.");

        IF p_Entity."Customer Model" <> '' THEN
            lRecEntityModel.GET(p_Entity."Customer Model");

        // Create the customer
        //--------------------
        CLEAR(lRecCustomer);
        lRecCustomer.INSERT(TRUE);

        lRecCustomer."Payment Days Code" := lRecCustomer."No.";
        lRecCustomer."Non-Paymt. Periods Code" := lRecCustomer."No.";
        lRecCustomer.VALIDATE(Name, p_Entity.Name);
        lRecCustomer.VALIDATE("Name 2", p_Entity."Name 2");
        lRecCustomer.Address := p_Entity.Address;
        lRecCustomer."Address 2" := p_Entity."Address 2";
        lRecCustomer."Post Code" := p_Entity."Postal Code";
        lRecCustomer.City := p_Entity.City;
        lRecCustomer.County := p_Entity.County;
        lRecCustomer."Country/Region Code" := p_Entity."Country Code";
        lRecCustomer.VALIDATE("Gen. Bus. Posting Group", p_Entity."Gen. Bus. Posting Group");
        lRecCustomer.VALIDATE("VAT Bus. Posting Group", p_Entity."VAT Bus. Posting Group");
        lRecCustomer.VALIDATE("Payment Terms Code", p_Entity."Payment Terms Code");
        lRecCustomer.VALIDATE("Payment Method Code", p_Entity."Payment Method Code");
        lRecCustomer."Currency Code" := p_Entity."Currency Code";
        lRecCustomer."Language Code" := p_Entity."Language Code";
        lRecCustomer."VAT Registration No." := p_Entity."VAT Registration No.";
        lRecCustomer.VALIDATE("Customer Posting Group", lRecEntityModel."Customer Posting Group");
        lRecCustomer."Entity No." := p_Entity."No.";
        lRecCustomer.MODIFY(TRUE);

        // Register the Customer int the Entity
        //-------------------------------------
        CLEAR(lRecEntityAssociation);
        lRecEntityAssociation."Entity VAT Registration No." := p_Entity."VAT Registration No.";
        lRecEntityAssociation."No." := lRecCustomer."No.";
        lRecEntityAssociation."Customer No." := lRecCustomer."No.";
        lRecEntityAssociation.Type := lRecEntityAssociation.Type::Customer;
        lRecEntityAssociation.Name := lRecCustomer.Name;
        lRecEntityAssociation."VAT Registration No." := lRecCustomer."VAT Registration No.";
        lRecEntityAssociation.CALCFIELDS("Customer Balance (LCY)");
        lRecEntityAssociation.INSERT();

        // Show the new customer
        //----------------------
        IF p_BoolShowCcust THEN BEGIN
            lRecCustomer.FILTERGROUP(10);
            lRecCustomer.SETRANGE("No.", lRecCustomer."No.");
            lRecCustomer.FILTERGROUP(0);

            CLEAR(lpgCustomer);
            lpgCustomer.SETRECORD(lRecCustomer);
            lpgCustomer.RUN();
        END;
    end;

    procedure CreateVendor(p_Entity: Record 31004376; p_BoolShowVendor: Boolean)
    var
        lRecVendor: Record 23;
        lRecPurchSetup: Record 312;
        lRecEntityModel: Record 31004377;
        lRecEntityAssociation: Record 31004378;
        lpgVendor: Page 26;
    begin
        // Create new customer from the entity
        //------------------------------------

        // Check if the Entity already has a customer
        //-------------------------------------------
        //p_Entity.TESTFIELD("Vendor No.",'');
        p_Entity.TESTFIELD("Gen. Bus. Posting Group");
        p_Entity.TESTFIELD("VAT Bus. Posting Group");
        p_Entity.TESTFIELD("Vendor Model");

        lRecPurchSetup.GET();
        lRecPurchSetup.TESTFIELD("Vendor Nos.");

        IF p_Entity."Vendor Model" <> '' THEN
            lRecEntityModel.GET(p_Entity."Vendor Model");

        // Create the Vendor
        //--------------------
        CLEAR(lRecVendor);
        lRecVendor.INSERT(TRUE);

        lRecVendor."Payment Days Code" := lRecVendor."No.";
        lRecVendor."Non-Paymt. Periods Code" := lRecVendor."No.";
        lRecVendor.VALIDATE(Name, p_Entity.Name);
        lRecVendor.VALIDATE("Name 2", p_Entity."Name 2");
        lRecVendor.Address := p_Entity.Address;
        lRecVendor."Address 2" := p_Entity."Address 2";
        lRecVendor."Post Code" := p_Entity."Postal Code";
        lRecVendor.City := p_Entity.City;
        lRecVendor.County := p_Entity.County;
        lRecVendor."Country/Region Code" := p_Entity."Country Code";
        lRecVendor.VALIDATE("Gen. Bus. Posting Group", p_Entity."Gen. Bus. Posting Group");
        lRecVendor.VALIDATE("VAT Bus. Posting Group", p_Entity."VAT Bus. Posting Group");
        lRecVendor.VALIDATE("Payment Terms Code", p_Entity."Payment Terms Code");
        lRecVendor.VALIDATE("Payment Method Code", p_Entity."Payment Method Code");
        lRecVendor."Currency Code" := p_Entity."Currency Code";
        lRecVendor."Language Code" := p_Entity."Language Code";
        lRecVendor."VAT Registration No." := p_Entity."VAT Registration No.";
        lRecVendor.VALIDATE("Vendor Posting Group", lRecEntityModel."Vendor Posting Group");
        lRecVendor."Entity No." := p_Entity."No.";

        lRecVendor.MODIFY(TRUE);

        // Register the Vendor in the Entity
        //-------------------------------------
        CLEAR(lRecEntityAssociation);
        lRecEntityAssociation."Entity VAT Registration No." := lRecVendor."VAT Registration No.";
        lRecEntityAssociation."No." := lRecVendor."No.";
        lRecEntityAssociation."Vendor No." := lRecVendor."No.";
        lRecEntityAssociation.Type := lRecEntityAssociation.Type::Vendor;
        lRecEntityAssociation.Name := lRecVendor.Name;
        lRecEntityAssociation."VAT Registration No." := lRecVendor."VAT Registration No.";
        lRecEntityAssociation.CALCFIELDS("Vendor Balance (LCY)");
        lRecEntityAssociation.INSERT();

        // Show the new Vendor
        //----------------------
        IF p_BoolShowVendor THEN BEGIN
            lRecVendor.FILTERGROUP(10);
            lRecVendor.SETRANGE("No.", lRecVendor."No.");
            lRecVendor.FILTERGROUP(0);

            CLEAR(lpgVendor);
            lpgVendor.SETRECORD(lRecVendor);
            lpgVendor.RUN();
        END;
    end;

    procedure CheckPTVATNo(vat_no: Text[20]): Boolean
    var
        xVATnumber: Integer;
        xCount: Integer;
        xCheckDigit: Integer;
        xValue: Integer;
    begin
        EVALUATE(xVATnumber, vat_no);
        IF (xVATnumber < 10000000) OR (xVATnumber > 999999999) THEN
            EXIT(FALSE);
        IF NOT ((COPYSTR(vat_no, 1, 1) = '1') OR
               (COPYSTR(vat_no, 1, 1) = '2') OR
               (COPYSTR(vat_no, 1, 1) = '5') OR
               (COPYSTR(vat_no, 1, 1) = '6') OR
               (COPYSTR(vat_no, 1, 1) = '9'))
        THEN
            EXIT(FALSE);

        FOR xCount := 1 TO 8 DO BEGIN
            EVALUATE(xValue, COPYSTR(vat_no, xCount, 1));
            xCheckDigit := xCheckDigit + (xValue * (10 - xCount));
        END;
        xCheckDigit := xCheckDigit - (ROUND(xCheckDigit / 11, 1, '<') * 11);
        IF (xCheckDigit = 0) OR (xCheckDigit = 1) THEN
            xCheckDigit := 0
        ELSE
            xCheckDigit := 11 - xCheckDigit;
        EVALUATE(xValue, COPYSTR(vat_no, 9, 1));

        IF xCheckDigit = xValue THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;

    procedure RegisterWithoutDiference(p_RecEntity: Record 31004376; p_CustLedgEntryFilter: Text[1024]; p_VendLedgEntryFilter: Text[1024]; p_BoolPost: Boolean)
    var
        lRecCustLedgEntry: Record 21;
        lRecVendLedgEntry: Record 25;
        lRecGenJnlLine: Record 81;
        lRecGenJnlLine_2: Record 81;
        lRecGenJnlLine_3: Record 81;
        lRecEntitySetup: Record 31004375;
        GenJnlTemplate: Record 80;
        lRecBankAccount: Record 270;
        GenJnlBatch: Record 232;
        lCduNoSeriesMgt: Codeunit 396;
        GenJnlPost: Codeunit 13;
        lpgBankAcc: Page 371;
        lpgGenJournal: Page 31004425;
        lCodDocumentNo: Code[20];
        lDecCustAmtToApply: Decimal;
        lDecVendorAmtToApply: Decimal;
        lDecDiference: Decimal;
        CustDiscountPP: Decimal;
        VendDiscountPP: Decimal;
        lIntLineNo: Integer;
        lOptDocumentType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,,,,,,,,,,,Bill;
        FirstCustDocType: Text[30];
        CustDocType: Text[30];
        FirstVendDocType: Text[30];
        VendDocType: Text[30];
    begin
        // Used to compare all Entity Ledger Entries and create Gen. Journal Lines

        lRecCustLedgEntry.SETVIEW(p_CustLedgEntryFilter);
        lRecVendLedgEntry.SETVIEW(p_VendLedgEntryFilter);

        lDecCustAmtToApply := 0;
        lDecVendorAmtToApply := 0;
        FirstCustDocType := '';
        CustDocType := '';
        FirstVendDocType := '';
        VendDocType := '';

        // Get Entity Setup
        lRecEntitySetup.GET();

        CLEAR(lRecCustLedgEntry);
        lRecCustLedgEntry.SETRANGE("Customer No.", p_RecEntity."Customer No. EntityAss");
        lRecCustLedgEntry.SETRANGE("Applies-to ID", USERID());
        IF lRecCustLedgEntry.FINDSET() THEN
            REPEAT
                CustDiscountPP := 0;
                lRecCustLedgEntry.CALCFIELDS("Remaining Amount");

                IF (lRecCustLedgEntry."Pmt. Discount Date" >= WORKDATE()) AND
                   (lRecCustLedgEntry."Remaining Amount" = lRecCustLedgEntry."Amount to Apply")
                THEN
                    CustDiscountPP := lRecCustLedgEntry."Remaining Pmt. Disc. Possible";

                lDecCustAmtToApply += lRecCustLedgEntry."Amount to Apply" - CustDiscountPP;
            UNTIL lRecCustLedgEntry.NEXT() = 0
        ELSE
            ERROR(Text1110002Lbl);

        CLEAR(lRecVendLedgEntry);
        lRecVendLedgEntry.SETRANGE("Vendor No.", p_RecEntity."Vendor No. EntityAss");
        lRecVendLedgEntry.SETRANGE("Applies-to ID", USERID());
        IF lRecVendLedgEntry.FINDSET() THEN
            REPEAT
                VendDiscountPP := 0;
                lRecVendLedgEntry.CALCFIELDS("Remaining Amount");

                IF (lRecVendLedgEntry."Pmt. Discount Date" >= WORKDATE()) AND
                   (lRecVendLedgEntry."Remaining Amount" = lRecVendLedgEntry."Amount to Apply")
                THEN
                    VendDiscountPP := lRecVendLedgEntry."Remaining Pmt. Disc. Possible";

                lDecVendorAmtToApply += lRecVendLedgEntry."Amount to Apply" - VendDiscountPP;
            UNTIL lRecVendLedgEntry.NEXT() = 0
        ELSE
            ERROR(Text1110002Lbl);


        IF ((lDecCustAmtToApply < 0) AND (lDecVendorAmtToApply < 0)) OR
           ((lDecCustAmtToApply > 0) AND (lDecVendorAmtToApply > 0))
        THEN
            ERROR(Text1110004Lbl);

        lOptDocumentType := lOptDocumentType::Payment;
        IF lDecCustAmtToApply < 0 THEN
            lOptDocumentType := lOptDocumentType::Refund;

        lDecDiference := 0;
        lDecDiference := lDecCustAmtToApply + lDecVendorAmtToApply;

        IF lDecDiference <> 0 THEN BEGIN
            MESSAGE(Text1110001Lbl);

            CLEAR(lpgBankAcc);
            lpgBankAcc.LOOKUPMODE := TRUE;
            IF lpgBankAcc.RUNMODAL() = ACTION::LookupOK THEN
                lpgBankAcc.GETRECORD(lRecBankAccount)
            ELSE
                ERROR('');
        END;


        //-------CUSTOMER----------------------------------
        GenJnlTemplate.GET(lRecEntitySetup."Entity Journal Template");

        CLEAR(GenJnlBatch);
        GenJnlBatch.GET(lRecEntitySetup."Entity Journal Template", lRecEntitySetup."Entity Journal Batch");
        GenJnlBatch.TESTFIELD("No. Series");

        lCodDocumentNo := lCduNoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", 0D, FALSE);

        CLEAR(lRecGenJnlLine);
        lRecGenJnlLine.SETRANGE("Journal Template Name", lRecEntitySetup."Entity Journal Template");
        lRecGenJnlLine.SETRANGE("Journal Batch Name", lRecEntitySetup."Entity Journal Batch");
        IF lRecGenJnlLine.FINDLAST() THEN
            lIntLineNo := lRecGenJnlLine."Line No.";

        lIntLineNo += 10000;

        CLEAR(lRecGenJnlLine);
        lRecGenJnlLine.INIT();
        lRecGenJnlLine.VALIDATE("Journal Template Name", lRecEntitySetup."Entity Journal Template");
        lRecGenJnlLine.VALIDATE("Journal Batch Name", lRecEntitySetup."Entity Journal Batch");
        lRecGenJnlLine.VALIDATE("Posting Date", WORKDATE());
        lRecGenJnlLine."Source Code" := GenJnlTemplate."Source Code";
        lRecGenJnlLine."Reason Code" := GenJnlBatch."Reason Code";
        lRecGenJnlLine."Posting No. Series" := GenJnlBatch."Posting No. Series";
        lRecGenJnlLine."Bal. Account Type" := GenJnlBatch."Bal. Account Type";
        IF (lRecGenJnlLine."Account Type" IN [lRecGenJnlLine."Account Type"::Customer,
                                                lRecGenJnlLine."Account Type"::Vendor,
                                                lRecGenJnlLine."Account Type"::"Fixed Asset"])
        AND
          (lRecGenJnlLine."Bal. Account Type" IN [lRecGenJnlLine."Bal. Account Type"::Customer,
                                                     lRecGenJnlLine."Bal. Account Type"::Vendor,
                                                     lRecGenJnlLine."Bal. Account Type"::"Fixed Asset"])
        THEN
            lRecGenJnlLine."Account Type" := lRecGenJnlLine."Account Type"::"G/L Account";

        lRecGenJnlLine.VALIDATE("Bal. Account No.", GenJnlBatch."Bal. Account No.");
        lRecGenJnlLine.VALIDATE("Line No.", lIntLineNo);
        lRecGenJnlLine.VALIDATE("Account Type", lRecGenJnlLine."Account Type"::Customer);
        lRecGenJnlLine.VALIDATE("Account No.", p_RecEntity."Customer No. EntityAss");
        lRecGenJnlLine.VALIDATE("Posting Date", WORKDATE());
        lRecGenJnlLine.VALIDATE("Document Type", lOptDocumentType);
        lRecGenJnlLine."Document No." := lCodDocumentNo;
        lRecGenJnlLine.VALIDATE(Description, p_RecEntity.Name);
        lRecGenJnlLine.VALIDATE(Amount, lDecCustAmtToApply * -1);
        lRecGenJnlLine.VALIDATE("Applies-to ID", lRecGenJnlLine."Document No.");
        lRecGenJnlLine.INSERT(TRUE);


        //-------VENDOR----------------------------------
        lIntLineNo += 10000;

        CLEAR(lRecGenJnlLine_2);
        lRecGenJnlLine_2.COPY(lRecGenJnlLine);
        lRecGenJnlLine_2.VALIDATE("Line No.", lIntLineNo);
        lRecGenJnlLine_2.VALIDATE("Account Type", lRecGenJnlLine_2."Account Type"::Vendor);
        lRecGenJnlLine_2.VALIDATE("Account No.", p_RecEntity."Vendor No. EntityAss");
        lRecGenJnlLine_2.VALIDATE(Description, p_RecEntity.Name);
        lRecGenJnlLine_2.VALIDATE(Amount, lDecVendorAmtToApply * -1);
        lRecGenJnlLine_2.VALIDATE("Applies-to ID", lRecGenJnlLine_2."Document No.");
        lRecGenJnlLine_2.INSERT(TRUE);


        //-------BANK ACCOUNT----------------------------------
        IF lDecDiference <> 0 THEN BEGIN
            lIntLineNo += 10000;

            CLEAR(lRecGenJnlLine_3);
            lRecGenJnlLine_3.COPY(lRecGenJnlLine);
            lRecGenJnlLine_3.VALIDATE("Line No.", lIntLineNo);
            lRecGenJnlLine_3.VALIDATE("Account Type", lRecGenJnlLine_3."Account Type"::"Bank Account");
            lRecGenJnlLine_3.VALIDATE("Account No.", lRecBankAccount."No.");
            lRecGenJnlLine_3.VALIDATE(Description, p_RecEntity.Name);
            lRecGenJnlLine_3.VALIDATE(Amount, lDecDiference);
            lRecGenJnlLine_3.VALIDATE("Applies-to ID", lRecGenJnlLine_3."Document No.");
            lRecGenJnlLine_3.INSERT(TRUE);
        END;

        lRecCustLedgEntry.SETRANGE("Customer No.", p_RecEntity."Customer No. EntityAss");
        lRecCustLedgEntry.SETRANGE("Applies-to ID", USERID());
        lRecCustLedgEntry.MODIFYALL("Applies-to ID", lRecGenJnlLine."Document No.");

        lRecVendLedgEntry.SETRANGE("Vendor No.", p_RecEntity."Vendor No. EntityAss");
        lRecVendLedgEntry.SETRANGE("Applies-to ID", USERID());
        lRecVendLedgEntry.MODIFYALL("Applies-to ID", lRecGenJnlLine."Document No.");

        COMMIT();

        lRecGenJnlLine.SETRANGE("Journal Template Name", lRecGenJnlLine_2."Journal Template Name");
        lRecGenJnlLine.SETRANGE("Journal Batch Name", lRecGenJnlLine_2."Journal Batch Name");
        lRecGenJnlLine.SETRANGE("Document No.", lRecGenJnlLine_2."Document No.");

        IF p_BoolPost THEN
            GenJnlPost.RUN(lRecGenJnlLine)
        ELSE BEGIN
            lCodDocumentNo := '';
            IF lRecGenJnlLine.FINDFIRST() THEN
                ;

            CLEAR(lpgGenJournal);
            lpgGenJournal.SETTABLEVIEW(lRecGenJnlLine);
            lpgGenJournal.RUNMODAL();

            IF lRecGenJnlLine.FINDSET() THEN
                REPEAT
                    IF lCodDocumentNo <> lRecGenJnlLine."Document No." THEN
                        lCodDocumentNo := lRecGenJnlLine."Document No.";

                    lRecCustLedgEntry.SETRANGE("Applies-to ID", lRecGenJnlLine."Document No.");
                    lRecCustLedgEntry.MODIFYALL("Applies-to ID", USERID());

                    lRecVendLedgEntry.SETRANGE("Applies-to ID", lRecGenJnlLine."Document No.");
                    lRecVendLedgEntry.MODIFYALL("Applies-to ID", USERID());
                UNTIL lRecGenJnlLine.NEXT() = 0;

            // Delete Journal Lines
            lRecGenJnlLine.DELETEALL(TRUE);
        END;
    end;

    procedure RegisterWithDiference(p_RecEntity: Record 31004376; p_CustLedgEntryFilter: Text[1024]; p_VendLedgEntryFilter: Text[1024]; p_BoolPost: Boolean)
    var
        lRecCustLedgEntry: Record 21;
        lRecVendLedgEntry: Record 25;
        lRecGenJnlLine: Record 81;
        lRecGenJnlLine_2: Record 81;
        lRecEntitySetup: Record 31004375;
        GenJnlTemplate: Record 80;
        lRecGenJnlBatch: Record 232;
        lRecEntity: Record 31004376;
        lRecCustLedgerEntryFilter: Record 21;
        lRptEntityReceipt: Report 31004381;
        lCduGenJnlPost: Codeunit 13;
        lCduNoSeriesMgt: Codeunit 396;
        lpgGenJournal: Page 31004425;
        lCodDocumentNo: Code[20];
        lDecCustAmtToApply: Decimal;
        lDecVendorAmtToApply: Decimal;
        lDecDiference: Decimal;
        lDecBalance: Decimal;
        CustDiscountPP: Decimal;
        VendDiscountPP: Decimal;
        AmountToApply: Decimal;
        lIntLineNo: Integer;
        lOptDocumentType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,,,,,,,,,,,Bill;
        FirstCustDocType: Text[30];
        CustDocType: Text[30];
        FirstVendDocType: Text[30];
        VendDocType: Text[30];
    begin
        // Used to compare all Entity Ledger Entries and create Gen. Journal Lines

        lRecCustLedgEntry.SETVIEW(p_CustLedgEntryFilter);
        lRecVendLedgEntry.SETVIEW(p_VendLedgEntryFilter);

        lDecCustAmtToApply := 0;
        lDecVendorAmtToApply := 0;
        lCodDocumentNo := '';
        FirstCustDocType := '';
        CustDocType := '';
        FirstVendDocType := '';
        VendDocType := '';

        // Get Entity Setup
        lRecEntitySetup.GET();


        //--------------------Customer ledger Entries-------------------
        CLEAR(lRecCustLedgEntry);
        lRecCustLedgEntry.SETRANGE("Customer No.", p_RecEntity."Customer No. EntityAss");
        lRecCustLedgEntry.SETRANGE("Applies-to ID", USERID());
        IF lRecCustLedgEntry.FINDSET() THEN
            REPEAT
                CustDiscountPP := 0;
                lRecCustLedgEntry.CALCFIELDS("Remaining Amount");
                IF (lRecCustLedgEntry."Pmt. Discount Date" >= WORKDATE()) AND
                   (lRecCustLedgEntry."Remaining Amount" = lRecCustLedgEntry."Amount to Apply")
                THEN
                    CustDiscountPP := lRecCustLedgEntry."Remaining Pmt. Disc. Possible";

                lDecCustAmtToApply += lRecCustLedgEntry."Amount to Apply";
            UNTIL lRecCustLedgEntry.NEXT() = 0
        ELSE
            ERROR(Text1110002Lbl);


        //-----------------Vendor Ledger Entries------------------
        CLEAR(lRecVendLedgEntry);
        lRecVendLedgEntry.SETRANGE("Vendor No.", p_RecEntity."Vendor No. EntityAss");
        lRecVendLedgEntry.SETRANGE("Applies-to ID", USERID());
        IF lRecVendLedgEntry.FINDSET() THEN
            REPEAT
                VendDiscountPP := 0;
                lRecVendLedgEntry.CALCFIELDS("Remaining Amount");
                IF (lRecVendLedgEntry."Pmt. Discount Date" >= WORKDATE()) AND
                   (lRecVendLedgEntry."Remaining Amount" = lRecVendLedgEntry."Amount to Apply")
                THEN
                    VendDiscountPP := lRecVendLedgEntry."Remaining Pmt. Disc. Possible";

                lDecVendorAmtToApply += lRecVendLedgEntry."Amount to Apply";
            UNTIL lRecVendLedgEntry.NEXT() = 0
        ELSE
            ERROR(Text1110002Lbl);


        IF ((lDecCustAmtToApply < 0) AND (lDecVendorAmtToApply < 0)) OR
           ((lDecCustAmtToApply > 0) AND (lDecVendorAmtToApply > 0))
        THEN
            ERROR(Text1110004Lbl);

        lOptDocumentType := lOptDocumentType::Payment;
        IF lDecCustAmtToApply < 0 THEN
            lOptDocumentType := lOptDocumentType::Refund;

        //---------------------------DIFERENCE---------------------------------------
        IF lRecCustLedgEntry."Document Type" = lRecCustLedgEntry."Document Type"::"Credit Memo" THEN
            lDecDiference := ABS(lDecVendorAmtToApply) - ABS(lDecCustAmtToApply)
        ELSE
            lDecDiference := ABS(lDecVendorAmtToApply) - ABS(lDecCustAmtToApply);

        //------------------------------BALANCE---------------------------------------
        lDecBalance := 0;
        IF lDecDiference > 0 THEN
            IF lRecCustLedgEntry.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    CustDiscountPP := 0;
                    AmountToApply := 0;
                    lRecCustLedgEntry.CALCFIELDS("Remaining Amount");

                    IF (lRecCustLedgEntry."Pmt. Discount Date" >= WORKDATE()) AND
                       (lRecCustLedgEntry."Remaining Amount" = lRecCustLedgEntry."Amount to Apply")
                    THEN
                        CustDiscountPP := lRecCustLedgEntry."Remaining Pmt. Disc. Possible";

                    IF (lDecBalance + ABS(lRecCustLedgEntry."Amount to Apply")) <= ABS(lDecVendorAmtToApply) THEN
                        lDecBalance += lRecCustLedgEntry."Amount to Apply" - CustDiscountPP
                    ELSE
                        AmountToApply := -lDecVendorAmtToApply - lDecBalance;

                    IF lRecCustLedgEntry."Amount to Apply" = 0 THEN
                        lRecCustLedgEntry."Applies-to ID" := '';
                    lRecCustLedgEntry.MODIFY();
                    lDecBalance += AmountToApply - CustDiscountPP;

                UNTIL lRecCustLedgEntry.NEXT() = 0

            ELSE
                IF lRecVendLedgEntry.FINDSET(TRUE, FALSE) THEN
                    REPEAT
                        VendDiscountPP := 0;
                        AmountToApply := 0;
                        lRecVendLedgEntry.CALCFIELDS("Remaining Amount");

                        IF (lRecVendLedgEntry."Pmt. Discount Date" >= WORKDATE()) AND
                           (lRecVendLedgEntry."Remaining Amount" = lRecVendLedgEntry."Amount to Apply")
                        THEN
                            VendDiscountPP := lRecVendLedgEntry."Remaining Pmt. Disc. Possible";

                        IF (lDecBalance - ABS(lRecVendLedgEntry."Amount to Apply")) <= ABS(lDecCustAmtToApply) THEN
                            lDecBalance -= lRecVendLedgEntry."Amount to Apply" - VendDiscountPP
                        ELSE
                            AmountToApply := -(lDecCustAmtToApply - lDecBalance);

                        IF lRecVendLedgEntry."Amount to Apply" = 0 THEN
                            lRecVendLedgEntry."Applies-to ID" := '';
                        lRecVendLedgEntry.MODIFY();

                        lDecBalance -= AmountToApply - VendDiscountPP;
                    UNTIL lRecVendLedgEntry.NEXT() = 0;

        //-------CUSTOMER----------------------------------
        GenJnlTemplate.GET(lRecEntitySetup."Entity Journal Template");

        CLEAR(lRecGenJnlBatch);
        lRecGenJnlBatch.GET(lRecEntitySetup."Entity Journal Template", lRecEntitySetup."Entity Journal Batch");
        lRecGenJnlBatch.TESTFIELD("No. Series");

        lCodDocumentNo := lCduNoSeriesMgt.GetNextNo(lRecGenJnlBatch."No. Series", 0D, FALSE);

        CLEAR(lRecGenJnlLine);
        lRecGenJnlLine.SETRANGE("Journal Template Name", lRecEntitySetup."Entity Journal Template");
        lRecGenJnlLine.SETRANGE("Journal Batch Name", lRecEntitySetup."Entity Journal Batch");
        IF lRecGenJnlLine.FINDLAST() THEN
            lIntLineNo := lRecGenJnlLine."Line No.";

        lIntLineNo += 10000;

        CLEAR(lRecGenJnlLine);
        lRecGenJnlLine.INIT();
        lRecGenJnlLine.VALIDATE("Journal Template Name", lRecEntitySetup."Entity Journal Template");
        lRecGenJnlLine.VALIDATE("Journal Batch Name", lRecEntitySetup."Entity Journal Batch");
        lRecGenJnlLine.VALIDATE("Posting Date", WORKDATE());
        lRecGenJnlLine."Source Code" := GenJnlTemplate."Source Code";
        lRecGenJnlLine."Reason Code" := lRecGenJnlBatch."Reason Code";
        lRecGenJnlLine."Posting No. Series" := lRecGenJnlBatch."Posting No. Series";
        lRecGenJnlLine."Bal. Account Type" := lRecGenJnlBatch."Bal. Account Type";
        IF (lRecGenJnlLine."Account Type" IN [lRecGenJnlLine."Account Type"::Customer,
                                                lRecGenJnlLine."Account Type"::Vendor,
                                                lRecGenJnlLine."Account Type"::"Fixed Asset"])
          AND
           (lRecGenJnlLine."Bal. Account Type" IN [
             lRecGenJnlLine."Bal. Account Type"::Customer,
             lRecGenJnlLine."Bal. Account Type"::Vendor,
             lRecGenJnlLine."Bal. Account Type"::"Fixed Asset"])
        THEN
            lRecGenJnlLine."Account Type" := lRecGenJnlLine."Account Type"::"G/L Account";

        lRecGenJnlLine.VALIDATE("Bal. Account No.", lRecGenJnlBatch."Bal. Account No.");
        lRecGenJnlLine.VALIDATE("Line No.", lIntLineNo);
        lRecGenJnlLine.VALIDATE("Account Type", lRecGenJnlLine."Account Type"::Customer);
        lRecGenJnlLine.VALIDATE("Account No.", p_RecEntity."Customer No. EntityAss");
        lRecGenJnlLine.VALIDATE("Document Type", lOptDocumentType);
        lRecGenJnlLine."Document No." := lCodDocumentNo;
        lRecGenJnlLine.VALIDATE(Description, p_RecEntity.Name);
        lRecGenJnlLine.VALIDATE(Amount, lDecBalance * -1);
        lRecGenJnlLine.VALIDATE("Applies-to ID", lRecGenJnlLine."Document No.");
        lRecGenJnlLine.INSERT();


        //-------VENDOR----------------------------------
        lIntLineNo += 10000;

        CLEAR(lRecGenJnlLine_2);
        lRecGenJnlLine_2.COPY(lRecGenJnlLine);
        lRecGenJnlLine_2.VALIDATE("Line No.", lIntLineNo);
        lRecGenJnlLine_2.VALIDATE("Account Type", lRecGenJnlLine_2."Account Type"::Vendor);
        lRecGenJnlLine_2.VALIDATE("Account No.", p_RecEntity."Vendor No. EntityAss");
        lRecGenJnlLine_2.VALIDATE(Description, p_RecEntity.Name);
        lRecGenJnlLine_2.VALIDATE(Amount, lDecBalance);
        lRecGenJnlLine_2.VALIDATE("Applies-to ID", lRecGenJnlLine_2."Document No.");
        lRecGenJnlLine_2.INSERT();

        lRecCustLedgEntry.SETRANGE("Customer No.", p_RecEntity."Customer No. EntityAss");
        lRecCustLedgEntry.SETRANGE("Applies-to ID", USERID());
        lRecCustLedgEntry.MODIFYALL("Applies-to ID", lRecGenJnlLine."Document No.");

        lRecVendLedgEntry.SETRANGE("Vendor No.", p_RecEntity."Vendor No. EntityAss");
        lRecVendLedgEntry.SETRANGE("Applies-to ID", USERID());
        lRecVendLedgEntry.MODIFYALL("Applies-to ID", lRecGenJnlLine."Document No.");

        COMMIT();

        lRecGenJnlLine.SETRANGE("Journal Template Name", lRecGenJnlLine_2."Journal Template Name");
        lRecGenJnlLine.SETRANGE("Journal Batch Name", lRecGenJnlLine_2."Journal Batch Name");
        lRecGenJnlLine.SETRANGE("Document No.", lRecGenJnlLine_2."Document No.");

        IF p_BoolPost THEN
            lCduGenJnlPost.RUN(lRecGenJnlLine)
        ELSE
            lCodDocumentNo := '';
        IF lRecGenJnlLine.FINDFIRST() THEN;

        CLEAR(lpgGenJournal);
        lpgGenJournal.SETTABLEVIEW(lRecGenJnlLine);
        lpgGenJournal.RUNMODAL();

        IF lRecGenJnlLine.FINDSET() THEN
            REPEAT
                IF lCodDocumentNo <> lRecGenJnlLine."Document No." THEN
                    lCodDocumentNo := lRecGenJnlLine."Document No.";

                lRecCustLedgEntry.SETRANGE("Applies-to ID", lRecGenJnlLine."Document No.");
                lRecCustLedgEntry.MODIFYALL("Applies-to ID", USERID());

                lRecVendLedgEntry.SETRANGE("Applies-to ID", lRecGenJnlLine."Document No.");
                lRecVendLedgEntry.MODIFYALL("Applies-to ID", USERID());
            UNTIL lRecGenJnlLine.NEXT() = 0;

        // Delete Journal lines
        lRecGenJnlLine.DELETEALL(TRUE);

        IF p_BoolPost THEN
            CLEAR(lRecEntity);
        CLEAR(lRecCustLedgerEntryFilter);
        lRecEntity.SETRANGE("No.", p_RecEntity."No.");
        lRecEntity.SETRANGE("Customer No. EntityAss", p_RecEntity."Customer No. EntityAss");
        lRecCustLedgerEntryFilter.SETRANGE("Document No.", lCodDocumentNo);
        lRptEntityReceipt.SetVariables(TRUE);
        lRptEntityReceipt.SETTABLEVIEW(lRecEntity);
        lRptEntityReceipt.SETTABLEVIEW(lRecCustLedgerEntryFilter);
        lRptEntityReceipt.USEREQUESTPAGE(FALSE);
        lRptEntityReceipt.RUN();
    end;
}

