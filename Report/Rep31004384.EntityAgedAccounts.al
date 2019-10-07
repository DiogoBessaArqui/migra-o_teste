report 31004384 "Entity - Aged Accounts"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Report </Comment>
    // //[*]</LMS>
    DefaultLayout = RDLC;
    RDLCLayout = './Entity - Aged Accounts.rdlc';

    Caption = 'Entity - Aged Accounts';
    Description = 'ID:ENTITY.00.01.01.00';

    dataset
    {
        dataitem(DataItem3901; 31004376)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(PrintAmountInLCY; PrintAmountInLCY_)
            {
            }
            column(gBoolShowCustomer; gBoolShowCustomer)
            {
            }
            column(gBoolShowVendor; gBoolShowVendor)
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(USERID; USERID())
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(Entity_Name; Name)
            {
            }
            column(Entity__No__; "No.")
            {
            }
            column(Aged_Accounts_EntityCaption; STRSUBSTNO(Aged_Accounts_EntityCaptionLbl, EndingDate_))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(EntityCaption; EntityCaptionLbl)
            {
            }
            column(STRSUBSTNO_Text006Lbl_FORMAT_EndingDate_0_4__; STRSUBSTNO(Text006Lbl, FORMAT(EndingDate_, 0, 4)))
            {
            }
            column(STRSUBSTNO_Text007Lbl_SELECTSTR_AgingBy___1_Text009Lbl__; STRSUBSTNO(Text007Lbl, SELECTSTR(AgingBy_ + 1, Text009Lbl)))
            {
            }
            column(HeaderText_5_; HeaderText[5])
            {
            }
            column(HeaderText_4_; HeaderText[4])
            {
            }
            column(HeaderText_3_; HeaderText[3])
            {
            }
            column(HeaderText_2_; HeaderText[2])
            {
            }
            column(HeaderText_1_; HeaderText[1])
            {
            }
            column(PrintDetails; PrintDetails_)
            {
            }
            dataitem(DataItem1000000051; 31004378)
            {
                DataItemLink = "Entity VAT Registration No." = FIELD("VAT Registration No.");
                DataItemTableView = SORTING(Type)
                                    ORDER(Ascending);
                dataitem(Customer; 18)
                {
                    DataItemLink = "No." = FIELD("Customer No.");
                    DataItemTableView = SORTING("No.");
                    dataitem(DataItem8503; 21)
                    {
                        DataItemLink = "Customer No." = FIELD("No.");
                        DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code");

                        trigger OnAfterGetRecord()
                        var
                            CustLedgEntry: Record 21;
                        begin
                            CustLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                            CustLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                            CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate_);
                            IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
                                REPEAT
                                    CustInsertTemp(CustLedgEntry);
                                UNTIL CustLedgEntry.NEXT() = 0;

                            IF "Closed by Entry No." <> 0 THEN BEGIN
                                CustLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                                IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
                                    REPEAT
                                        CustInsertTemp(CustLedgEntry);
                                    UNTIL CustLedgEntry.NEXT() = 0;
                            END;


                            CustLedgEntry.RESET();
                            CustLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                            CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate_);
                            IF CustLedgEntry.FINDSET(FALSE, FALSE) THEN
                                REPEAT
                                    CustInsertTemp(CustLedgEntry);
                                UNTIL CustLedgEntry.NEXT() = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE("Posting Date", EndingDate_ + 1, 99991231D);
                        end;
                    }
                    dataitem(OpenCustLedgEntry; 21)
                    {
                        DataItemLink = "Customer No." = FIELD("No.");
                        DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date", "Currency Code");

                        trigger OnAfterGetRecord()
                        begin
                            IF AgingBy_ = AgingBy_::"Posting Date" THEN BEGIN
                                CALCFIELDS("Remaining Amt. (LCY)");
                                IF "Remaining Amt. (LCY)" = 0 THEN
                                    CurrReport.SKIP();
                            END;

                            CustInsertTemp(OpenCustLedgEntry);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF AgingBy_ = AgingBy_::"Posting Date" THEN BEGIN
                                SETRANGE("Posting Date", 0D, EndingDate_);
                                SETRANGE("Date Filter", 0D, EndingDate_);
                            END;
                        end;
                    }
                    dataitem(CustCurrencyLoop; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        PrintOnlyIfDetail = true;
                        dataitem(TempCustLedgEntryLoop; 2000000026)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(Entity_Association_Type_Cust; FORMAT("Entity Association".Type))
                            {
                            }
                            column(Customer_No; Customer."No.")
                            {
                            }
                            column(Customer_Name; Customer.Name)
                            {
                            }
                            column(CustLedgEntryEndingDate_Posting_Date_Caption; CustLedgEntryEndingDate.FIELDCAPTION("Posting Date"))
                            {
                            }
                            column(CustLedgEntryEndingDate_Document_Type_Caption; PADSTR(CustLedgEntryEndingDate.FIELDCAPTION("Document Type"), 2))
                            {
                            }
                            column(CustLedgEntryEndingDate_Document_No_Caption; CustLedgEntryEndingDate.FIELDCAPTION("Document No."))
                            {
                            }
                            column(CustLedgEntryEndingDate_Due_Date_Caption; PADSTR(CustLedgEntryEndingDate.FIELDCAPTION("Due Date"), 10))
                            {
                            }
                            column(CustLedgEntryEndingDate_Remaining_Amount_Caption; LMS_Balance_CapLbl)
                            {
                            }
                            column(CustLedgEntryEndingDate_Amount_Caption; LMS_OriginAmt_CapLbl)
                            {
                            }
                            column(CustLedgEntryEndingDate_Posting_Date; CustLedgEntryEndingDate."Posting Date")
                            {
                            }
                            column(CustLedgEntryEndingDate_Document_Type; PADSTR(FORMAT(CustLedgEntryEndingDate."Document Type"), 2))
                            {
                            }
                            column(CustLedgEntryEndingDate_Document_No; CustLedgEntryEndingDate."Document No.")
                            {
                            }
                            column(CustLedgEntryEndingDate_Due_Date; CustLedgEntryEndingDate."Due Date")
                            {
                            }
                            column(CustLedgEntryEndingDate_Amount; CustLedgEntryEndingDate.Amount)
                            {
                            }
                            column(CustLedgEntryEndingDate_Remaining_Amount; CustLedgEntryEndingDate."Remaining Amount")
                            {
                            }
                            column(AgedCustLedgEntry_Remaining_Amount1; AgedCustLedgEntry[1]."Remaining Amount")
                            {
                            }
                            column(AgedCustLedgEntry_Remaining_Amount2; AgedCustLedgEntry[2]."Remaining Amount")
                            {
                            }
                            column(AgedCustLedgEntry_Remaining_Amount3; AgedCustLedgEntry[3]."Remaining Amount")
                            {
                            }
                            column(AgedCustLedgEntry_Remaining_Amount4; AgedCustLedgEntry[4]."Remaining Amount")
                            {
                            }
                            column(AgedCustLedgEntry_Remaining_Amount5; AgedCustLedgEntry[5]."Remaining Amount")
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                PeriodIndex: Integer;
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT TempCustLedgEntry.FINDSET(FALSE, FALSE) THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF TempCustLedgEntry.NEXT() = 0 THEN
                                        CurrReport.BREAK();

                                CustLedgEntryEndingDate := TempCustLedgEntry;
                                DetailedCustomerLedgerEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntryEndingDate."Entry No.");
                                DetailedCustomerLedgerEntry.SETFILTER("Excluded from calculation", '%1', FALSE);
                                IF DetailedCustomerLedgerEntry.FINDSET() THEN
                                    REPEAT
                                        IF (DetailedCustomerLedgerEntry."Entry Type" =
                                            DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry") AND
                                           (CustLedgEntryEndingDate."Posting Date" > EndingDate_) AND
                                           (AgingBy_ <> AgingBy_::"Posting Date")
                                        THEN
                                            IF CustLedgEntryEndingDate."Document Date" <= EndingDate_ THEN
                                                DetailedCustomerLedgerEntry."Posting Date" :=
                                                  CustLedgEntryEndingDate."Document Date"
                                            ELSE
                                                IF (CustLedgEntryEndingDate."Due Date" <= EndingDate_) AND
                                                   (AgingBy_ = AgingBy_::"Due Date")
                                                THEN
                                                    DetailedCustomerLedgerEntry."Posting Date" :=
                                                      CustLedgEntryEndingDate."Due Date";

                                        IF DetailedCustomerLedgerEntry."Posting Date" <= EndingDate_ THEN BEGIN
                                            IF DetailedCustomerLedgerEntry."Entry Type" IN
                                              [DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry",
                                               DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Loss",
                                               DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Gain",
                                               DetailedCustomerLedgerEntry."Entry Type"::"Realized Loss",
                                               DetailedCustomerLedgerEntry."Entry Type"::"Realized Gain",
                                               DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount",
                                               DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                               DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                               DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance",
                                               DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                               DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                               DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                               DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                               DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
                                            THEN BEGIN
                                                CustLedgEntryEndingDate.Amount := CustLedgEntryEndingDate.Amount + DetailedCustomerLedgerEntry.Amount;
                                                CustLedgEntryEndingDate."Amount (LCY)" :=
                                                  CustLedgEntryEndingDate."Amount (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                            END;
                                            CustLedgEntryEndingDate."Remaining Amount" :=
                                              CustLedgEntryEndingDate."Remaining Amount" + DetailedCustomerLedgerEntry.Amount;
                                            CustLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                              CustLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                        END;
                                    UNTIL DetailedCustomerLedgerEntry.NEXT() = 0;

                                IF CustLedgEntryEndingDate."Remaining Amount" = 0 THEN
                                    CurrReport.SKIP();

                                CASE AgingBy_ OF
                                    AgingBy_::"Due Date":
                                        PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Due Date");
                                    AgingBy_::"Posting Date":
                                        PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Posting Date");
                                    AgingBy_::"Document Date":
                                        BEGIN
                                            IF CustLedgEntryEndingDate."Document Date" > EndingDate_ THEN BEGIN
                                                CustLedgEntryEndingDate."Remaining Amount" := 0;
                                                CustLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                                CustLedgEntryEndingDate."Document Date" := CustLedgEntryEndingDate."Posting Date";
                                            END;
                                            PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Document Date");
                                        END;
                                END;
                                CLEAR(AgedCustLedgEntry);
                                AgedCustLedgEntry[PeriodIndex]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                                AgedCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                                TotalCustLedgEntry[PeriodIndex]."Remaining Amount" += CustLedgEntryEndingDate."Remaining Amount";
                                TotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                                GrandTotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                                TotalCustLedgEntry[1].Amount += CustLedgEntryEndingDate."Remaining Amount";
                                TotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                                GrandTotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                            end;

                            trigger OnPostDataItem()
                            begin
                                IF NOT PrintAmountInLCY_ THEN
                                    UpdateCurrencyTotals();
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT PrintAmountInLCY_ THEN
                                    TempCustLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            CLEAR(TotalCustLedgEntry);

                            IF Number = 1 THEN BEGIN
                                IF NOT TempCurrency.FINDSET(FALSE, FALSE) THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF TempCurrency.NEXT() = 0 THEN
                                    CurrReport.BREAK();

                            IF TempCurrency.Code <> '' THEN
                                CurrencyCode := TempCurrency.Code
                            ELSE
                                CurrencyCode := GLSetup."LCY Code";

                            NumberOfCurrencies := NumberOfCurrencies + 1;
                        end;

                        trigger OnPostDataItem()
                        begin
                            IF NewPagePercustomer_ AND (NumberOfCurrencies > 0) THEN
                                CurrReport.NEWPAGE();
                        end;

                        trigger OnPreDataItem()
                        begin
                            NumberOfCurrencies := 0;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        TempCurrency.RESET();
                        TempCurrency.DELETEALL();
                        TempCustLedgEntry.RESET();
                        TempCustLedgEntry.DELETEALL();
                    end;
                }
                dataitem(CustCurrencyTotals; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT TempCurrency2.FINDSET(FALSE, FALSE) THEN
                                CurrReport.BREAK();
                        END ELSE
                            IF TempCurrency2.NEXT() = 0 THEN
                                CurrReport.BREAK();

                        CLEAR(AgedCustLedgEntry);
                        TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                        IF TempCurrencyAmount.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                IF TempCurrencyAmount.Date <> 99991231D THEN
                                    AgedCustLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                                      TempCurrencyAmount.Amount
                                ELSE
                                    AgedCustLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                            UNTIL TempCurrencyAmount.NEXT() = 0;
                    end;
                }
                dataitem(DataItem3182; 23)
                {
                    DataItemLink = "No." = FIELD("Vendor No.");
                    DataItemTableView = SORTING("No.");
                    dataitem(DataItem4114; 25)
                    {
                        DataItemLink = "Vendor No." = FIELD("No.");
                        DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code");

                        trigger OnAfterGetRecord()
                        var
                            VendorLedgEntry: Record 25;
                        begin


                            VendorLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                            VendorLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                            VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate_);
                            IF VendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                                REPEAT
                                    VendInsertTemp(VendorLedgEntry);
                                UNTIL VendorLedgEntry.NEXT() = 0;

                            IF "Closed by Entry No." <> 0 THEN BEGIN
                                VendorLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                                IF VendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                                    REPEAT
                                        VendInsertTemp(VendorLedgEntry);
                                    UNTIL VendorLedgEntry.NEXT() = 0;
                            END;

                            VendorLedgEntry.RESET();
                            VendorLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                            VendorLedgEntry.SETRANGE("Posting Date", 0D, EndingDate_);
                            IF VendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                                REPEAT
                                    VendInsertTemp(VendorLedgEntry);
                                UNTIL VendorLedgEntry.NEXT() = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE("Posting Date", EndingDate_ + 1, 99991231D);
                        end;
                    }
                    dataitem(OpenVendorLedgEntry; 25)
                    {
                        DataItemLink = "Vendor No." = FIELD("No.");
                        DataItemTableView = SORTING("Vendor No.", Open, Positive, "Due Date", "Currency Code");

                        trigger OnAfterGetRecord()
                        begin
                            IF AgingBy_ = AgingBy_::"Posting Date" THEN BEGIN
                                CALCFIELDS("Remaining Amt. (LCY)");
                                IF "Remaining Amt. (LCY)" = 0 THEN
                                    CurrReport.SKIP();
                            END;
                            VendInsertTemp(OpenVendorLedgEntry);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF AgingBy_ = AgingBy_::"Posting Date" THEN BEGIN
                                SETRANGE("Posting Date", 0D, EndingDate_);
                                SETRANGE("Date Filter", 0D, EndingDate_);
                            END
                        end;
                    }
                    dataitem(CurrencyLoop; 2000000026)

                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        dataitem(TempVendortLedgEntryLoop; 2000000026)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE("Number" = FILTER(1 ..));
                            column(Entity_Association_Type_Vendor; FORMAT("Entity Association".Type))
                            {
                            }
                            column(Vendor_No; Vendor."No.")
                            {
                            }
                            column(Vendor_Name; Vendor.Name)
                            {
                            }
                            column(VendorLedgEntryEndingDate_Posting_Date; VendorLedgEntryEndingDate."Posting Date")
                            {
                            }
                            column(VendorLedgEntryEndingDate_Document_Type; PADSTR(FORMAT(VendorLedgEntryEndingDate."Document Type"), 2))
                            {
                            }
                            column(VendorLedgEntryEndingDate_Document_No; VendorLedgEntryEndingDate."Document No.")
                            {
                            }
                            column(VendorLedgEntryEndingDate_Due_Date; VendorLedgEntryEndingDate."Due Date")
                            {
                            }
                            column(VendorLedgEntryEndingDate_Amount; VendorLedgEntryEndingDate.Amount)
                            {
                            }
                            column(VendorLedgEntryEndingDate_Remaining_Amount; VendorLedgEntryEndingDate."Remaining Amount")
                            {
                            }
                            column(AgedVendorLedgEntry_Remaining_Amount1; AgedVendorLedgEntry[1]."Remaining Amount")
                            {
                            }
                            column(AgedVendorLedgEntry_Remaining_Amount2; AgedVendorLedgEntry[2]."Remaining Amount")
                            {
                            }
                            column(AgedVendorLedgEntry_Remaining_Amount3; AgedVendorLedgEntry[3]."Remaining Amount")
                            {
                            }
                            column(AgedVendorLedgEntry_Remaining_Amount4; AgedVendorLedgEntry[4]."Remaining Amount")
                            {
                            }
                            column(AgedVendorLedgEntry_Remaining_Amount5; AgedVendorLedgEntry[5]."Remaining Amount")
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                PeriodIndex: Integer;
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT TempVendorLedgEntry.FINDSET(FALSE, FALSE) THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF TempVendorLedgEntry.NEXT() = 0 THEN
                                        CurrReport.BREAK();

                                VendorLedgEntryEndingDate := TempVendorLedgEntry;
                                DetailedVendorLedgerEntry.SETRANGE("Vendor Ledger Entry No.", VendorLedgEntryEndingDate."Entry No.");
                                IF DetailedVendorLedgerEntry.FINDSET() THEN
                                    REPEAT
                                        IF (DetailedVendorLedgerEntry."Entry Type" =
                                            DetailedVendorLedgerEntry."Entry Type"::"Initial Entry") AND
                                           (VendorLedgEntryEndingDate."Posting Date" > EndingDate_) AND
                                           (AgingBy_ <> AgingBy_::"Posting Date")
                                        THEN
                                            IF VendorLedgEntryEndingDate."Document Date" <= EndingDate_ THEN
                                                DetailedVendorLedgerEntry."Posting Date" :=
                                                  VendorLedgEntryEndingDate."Document Date"
                                            ELSE
                                                IF (VendorLedgEntryEndingDate."Due Date" <= EndingDate_) AND
                                                   (AgingBy_ = AgingBy_::"Due Date")
                                                THEN
                                                    DetailedVendorLedgerEntry."Posting Date" :=
                                                      VendorLedgEntryEndingDate."Due Date";

                                        IF DetailedVendorLedgerEntry."Posting Date" <= EndingDate_ THEN BEGIN
                                            IF DetailedVendorLedgerEntry."Entry Type" IN
                                              [DetailedVendorLedgerEntry."Entry Type"::"Initial Entry",
                                               DetailedVendorLedgerEntry."Entry Type"::"Unrealized Loss",
                                               DetailedVendorLedgerEntry."Entry Type"::"Unrealized Gain",
                                               DetailedVendorLedgerEntry."Entry Type"::"Realized Loss",
                                               DetailedVendorLedgerEntry."Entry Type"::"Realized Gain",
                                               DetailedVendorLedgerEntry."Entry Type"::"Payment Discount",
                                               DetailedVendorLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                               DetailedVendorLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                               DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance",
                                               DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                               DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                               DetailedVendorLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                               DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                               DetailedVendorLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
                                            THEN BEGIN
                                                VendorLedgEntryEndingDate.Amount := VendorLedgEntryEndingDate.Amount + DetailedVendorLedgerEntry.Amount;
                                                VendorLedgEntryEndingDate."Amount (LCY)" :=
                                                  VendorLedgEntryEndingDate."Amount (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                            END;
                                            VendorLedgEntryEndingDate."Remaining Amount" :=
                                              VendorLedgEntryEndingDate."Remaining Amount" + DetailedVendorLedgerEntry.Amount;
                                            VendorLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                              VendorLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                        END;
                                    UNTIL DetailedVendorLedgerEntry.NEXT() = 0;

                                IF VendorLedgEntryEndingDate."Remaining Amount" = 0 THEN
                                    CurrReport.SKIP();

                                CASE AgingBy_ OF
                                    AgingBy_::"Due Date":
                                        PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Due Date");
                                    AgingBy_::"Posting Date":
                                        PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Posting Date");
                                    AgingBy_::"Document Date":
                                        BEGIN
                                            IF VendorLedgEntryEndingDate."Document Date" > EndingDate_ THEN BEGIN
                                                VendorLedgEntryEndingDate."Remaining Amount" := 0;
                                                VendorLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                                VendorLedgEntryEndingDate."Document Date" := VendorLedgEntryEndingDate."Posting Date";
                                            END;
                                            PeriodIndex := GetPeriodIndex(VendorLedgEntryEndingDate."Document Date");
                                        END;
                                END;
                                CLEAR(AgedVendorLedgEntry);
                                AgedVendorLedgEntry[PeriodIndex]."Remaining Amount" := VendorLedgEntryEndingDate."Remaining Amount";
                                AgedVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                                TotalVendorLedgEntry[PeriodIndex]."Remaining Amount" += VendorLedgEntryEndingDate."Remaining Amount";
                                TotalVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                                GrandTotalVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                                TotalVendorLedgEntry[1].Amount += VendorLedgEntryEndingDate."Remaining Amount";
                                TotalVendorLedgEntry[1]."Amount (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                                GrandTotalVendorLedgEntry[1]."Amount (LCY)" += VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                            end;

                            trigger OnPostDataItem()
                            begin
                                IF NOT PrintAmountInLCY_ THEN
                                    UpdateCurrencyTotals();
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT PrintAmountInLCY_ THEN
                                    TempVendorLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            CLEAR(TotalVendorLedgEntry);

                            IF Number = 1 THEN BEGIN
                                IF NOT TempCurrency.FINDSET(FALSE, FALSE) THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF TempCurrency.NEXT() = 0 THEN
                                    CurrReport.BREAK();

                            IF TempCurrency.Code <> '' THEN
                                CurrencyCode := TempCurrency.Code
                            ELSE
                                CurrencyCode := GLSetup."LCY Code";

                            NumberOfCurrencies := NumberOfCurrencies + 1;
                        end;

                        trigger OnPostDataItem()
                        begin
                            IF NewPagePerVendor AND (NumberOfCurrencies > 0) THEN
                                CurrReport.NEWPAGE();
                        end;

                        trigger OnPreDataItem()
                        begin
                            NumberOfCurrencies := 0;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        TempCurrency.RESET();
                        TempCurrency.DELETEALL();
                        TempVendorLedgEntry.RESET();
                        TempVendorLedgEntry.DELETEALL();
                    end;
                }
                dataitem(CurrencyTotals; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT TempCurrency2.FINDSET(FALSE, FALSE) THEN
                                CurrReport.BREAK();
                        END ELSE
                            IF TempCurrency2.NEXT() = 0 THEN
                                CurrReport.BREAK();

                        CLEAR(AgedVendorLedgEntry);
                        TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                        IF TempCurrencyAmount.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                IF TempCurrencyAmount.Date <> 99991231D THEN
                                    AgedVendorLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                                      TempCurrencyAmount.Amount
                                ELSE
                                    AgedVendorLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                            UNTIL TempCurrencyAmount.NEXT() = 0;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            var
                lRecEntityAss: Record 31004378;
            begin
                CLEAR(gBoolShowVendor);
                CLEAR(gBoolShowCustomer);

                CLEAR(lRecEntityAss);
                lRecEntityAss.SETRANGE("Entity VAT Registration No.", "VAT Registration No.");
                lRecEntityAss.SETRANGE(Type, lRecEntityAss.Type::Customer);
                lRecEntityAss.CALCFIELDS("Customer Balance (LCY)");
                lRecEntityAss.SETFILTER("Customer Balance (LCY)", '<>0');
                IF NOT lRecEntityAss.ISEMPTY() THEN
                    gBoolShowCustomer := TRUE;

                CLEAR(lRecEntityAss);
                lRecEntityAss.SETRANGE("Entity VAT Registration No.", "VAT Registration No.");
                lRecEntityAss.SETRANGE(Type, lRecEntityAss.Type::Vendor);
                lRecEntityAss.CALCFIELDS("Vendor Balance (LCY)");
                lRecEntityAss.SETFILTER("Vendor Balance (LCY)", '<>0');
                IF NOT lRecEntityAss.ISEMPTY() THEN
                    gBoolShowVendor := TRUE;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(EndingDate; EndingDate_)
                {
                    Caption = 'Aged As Of';
                }
                field(AgingBy; AgingBy_)
                {
                    Caption = 'Document Date';
                    OptionCaption = 'Due Date,Posting Date,Document Date';
                }
                field(PeriodLength; PeriodLength_)
                {
                    Caption = 'Period Length';
                }
                field(PrintAmountInLCY; PrintAmountInLCY_)
                {
                    Caption = 'Print Amounts in LCY';
                    Visible = false;
                }
                field(PrintDetails; PrintDetails_)
                {
                    Caption = 'Print Details';
                }
                field(HeadingType; HeadingType_)
                {
                    Caption = 'Heading Type';
                    OptionCaption = 'Date Interval,Number of Days';
                }
                field(NewPagePercustomer; NewPagePercustomer_)
                {
                    Caption = 'New Page per Customer';
                    Visible = false;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        LMS_SubTotal_Caption = 'SubTotal';
        LMS_Total_Caption = 'Total';
        LMS_GrandTotal_Caption = 'Final Total';
        LMS_SubTotalLCY_Caption = 'SubTotal (LCY)';
        LMS_TotalLCY_Caption = 'Total (LCY)';
        LMS_GrandTotalLCY_Caption = 'Final Total(LCY)';
        LMS_Customer_Caption = 'Customer';
        LMS_Vendor_Caption = 'Vendor';
        LMS_DocType_Caption = 'Ti D';
    }

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS();

        GLSetup.GET();

        CalcDates();
        CreateHeadings();
    end;

    var
        Vendor: Record Vendor;
        "Entity Association": Record "Entity Association";
        GLSetup: Record 98;
        TempCustLedgEntry: Record 21 temporary;
        TempVendorLedgEntry: Record 25 temporary;
        CustLedgEntryEndingDate: Record 21;
        TotalCustLedgEntry: array[5] of Record 21;
        GrandTotalCustLedgEntry: array[5] of Record 21;
        AgedCustLedgEntry: array[6] of Record 21;
        TempCurrency: Record 4 temporary;
        TempCurrency2: Record 4 temporary;
        TempCurrencyAmount: Record 264 temporary;
        DetailedCustomerLedgerEntry: Record 379;
        VendorLedgEntryEndingDate: Record 25;
        DetailedVendorLedgerEntry: Record 380;
        TotalVendorLedgEntry: array[5] of Record 25;
        GrandTotalVendorLedgEntry: array[5] of Record 25;
        AgedVendorLedgEntry: array[6] of Record 25;
        PeriodLength_: DateFormula;
        CustFilter: Text[250];
        PrintAmountInLCY_: Boolean;
        EndingDate_: Date;
        AgingBy_: Option "Due Date","Posting Date","Document Date";

        PrintDetails_: Boolean;
        HeadingType_: Option "Date Interval","Number of Days";
        NewPagePercustomer_: Boolean;
        PeriodStartDate: array[5] of Date;
        PeriodEndDate: array[5] of Date;
        HeaderText: array[5] of Text[30];
        Text000Lbl: Label 'Not Due';
        Text001Lbl: Label 'Before';
        CurrencyCode: Code[10];
        Text002Lbl: Label 'days';
        Text003Lbl: Label 'More than';
        Text006Lbl: Label 'Aged as of %1';
        Text007Lbl: Label 'Aged by %1';
        NumberOfCurrencies: Integer;
        Text009Lbl: Label 'Due Date,Posting Date,Document Date';
        Text010Lbl: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';


        NewPagePerVendor: Boolean;

        Aged_Accounts_EntityCaptionLbl: Label 'Aged Accounts Entity';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        EntityCaptionLbl: Label 'Entity';
        gBoolShowCustomer: Boolean;
        gBoolShowVendor: Boolean;
        LMS_Balance_CapLbl: Label 'Balance';
        LMS_OriginAmt_CapLbl: Label 'Original Amount';

    local procedure CalcDates()
    var
        PeriodLength2: DateFormula;
        i: Integer;

    begin
        EVALUATE(PeriodLength2, '-' + FORMAT(PeriodLength_));
        IF AgingBy_ = AgingBy_::"Due Date" THEN BEGIN
            PeriodEndDate[1] := 99991231D;
            PeriodStartDate[1] := EndingDate_ + 1;
        END ELSE BEGIN
            PeriodEndDate[1] := EndingDate_;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDate_ + 1);
        END;
        FOR i := 2 TO ARRAYLEN(PeriodEndDate) DO BEGIN
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i] + 1);
        END;
        PeriodStartDate[i] := 0D;

        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF PeriodEndDate[i] < PeriodStartDate[i] THEN
                ERROR(Text010Lbl, PeriodLength_);
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        IF AgingBy_ = AgingBy_::"Due Date" THEN BEGIN
            HeaderText[1] := Text000Lbl;
            i := 2;
        END ELSE
            i := 1;
        WHILE i < ARRAYLEN(PeriodEndDate) DO BEGIN
            IF HeadingType_ = HeadingType_::"Date Interval" THEN
                HeaderText[i] := STRSUBSTNO('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            ELSE
                HeaderText[i] :=
                  STRSUBSTNO('%1 - %2 %3', EndingDate_ - PeriodEndDate[i] + 1, EndingDate_ - PeriodStartDate[i] + 1, Text002Lbl);
            i := i + 1;
        END;
        IF HeadingType_ = HeadingType_::"Date Interval" THEN
            HeaderText[i] := STRSUBSTNO('%1 %2', Text001Lbl, PeriodStartDate[i - 1])
        ELSE
            HeaderText[i] := STRSUBSTNO('%1 \%2 %3', Text003Lbl, EndingDate_ - PeriodStartDate[i - 1] + 1, Text002Lbl);
    end;

    local procedure CustInsertTemp(var CustLedgEntry: Record 21)
    var
        Currency: Record 4;
    begin
        WITH TempCustLedgEntry DO BEGIN
            IF GET(CustLedgEntry."Entry No.") THEN
                EXIT;
            TempCustLedgEntry := CustLedgEntry;
            INSERT();
            IF PrintAmountInLCY_ THEN BEGIN
                CLEAR(TempCurrency);
                TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
                IF TempCurrency.INSERT() THEN;
                EXIT;
            END;
            IF TempCurrency.GET("Currency Code") THEN
                EXIT;
            IF "Currency Code" <> '' THEN
                Currency.GET("Currency Code")
            ELSE BEGIN
                CLEAR(Currency);
                Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            END;
            TempCurrency := Currency;
            TempCurrency.INSERT();
        END;
    end;

    local procedure GetPeriodIndex(Date: Date): Integer
    var
        i: Integer;
    begin
        FOR i := 1 TO ARRAYLEN(PeriodEndDate) DO
            IF Date IN [PeriodStartDate[i] .. PeriodEndDate[i]] THEN
                EXIT(i);
    end;

    local procedure Pct(a: Decimal; b: Decimal): Text[30]
    begin
        IF b <> 0 THEN
            EXIT(FORMAT(ROUND(100 * a / b, 0.1), 0, '<Sign><Integer><Decimals,2>') + '%');
    end;

    local procedure UpdateCurrencyTotals()
    var
        i: Integer;
    begin
        TempCurrency2.Code := CurrencyCode;
        IF TempCurrency2.INSERT() THEN;
        WITH TempCurrencyAmount DO BEGIN
            FOR i := 1 TO ARRAYLEN(TotalCustLedgEntry) DO BEGIN
                "Currency Code" := CurrencyCode;
                Date := PeriodStartDate[i];
                IF FIND() THEN BEGIN
                    Amount := Amount + TotalCustLedgEntry[i]."Remaining Amount";
                    MODIFY();
                END ELSE BEGIN
                    "Currency Code" := CurrencyCode;
                    Date := PeriodStartDate[i];
                    Amount := TotalCustLedgEntry[i]."Remaining Amount";
                    INSERT();
                END;
            END;
            "Currency Code" := CurrencyCode;
            Date := 99991231D;
            IF FIND() THEN BEGIN
                Amount := Amount + TotalCustLedgEntry[1].Amount;
                MODIFY();
            END ELSE BEGIN
                "Currency Code" := CurrencyCode;
                Date := 99991231D;
                Amount := TotalCustLedgEntry[1].Amount;
                INSERT();
            END;
        END;
    end;

    local procedure VendInsertTemp(var VendorLedgEntry: Record 25)
    var
        Currency: Record 4;
    begin
        WITH TempVendorLedgEntry DO BEGIN
            IF GET(VendorLedgEntry."Entry No.") THEN
                EXIT;
            TempVendorLedgEntry := VendorLedgEntry;
            INSERT();
            IF PrintAmountInLCY_ THEN BEGIN
                CLEAR(TempCurrency);
                TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
                IF TempCurrency.INSERT() THEN;
                EXIT;
            END;
            IF TempCurrency.GET("Currency Code") THEN
                EXIT;
            IF "Currency Code" <> '' THEN
                Currency.GET("Currency Code")
            ELSE BEGIN
                CLEAR(Currency);
                Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            END;
            TempCurrency := Currency;
            TempCurrency.INSERT();
        END;
    end;
}

