report 31004382 "Entity Trial Balance"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.10.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Report </Comment>
    // //[*]</LMS>
    DefaultLayout = RDLC;
    RDLCLayout = './Entity Trial Balance.rdlc';

    Caption = 'Entity Trial Balance';
    Description = 'ID:ENTITY.00.10.01.00';

    dataset
    {
        dataitem(DataItem3901; 31004376)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Date Filter";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(USERID; USERID())
            {
            }
            column(STRSUBSTNO_Text003Lbl_PeriodStartDate_PeriodEndDate_; STRSUBSTNO(Text003Lbl, PeriodStartDate, PeriodEndDate))
            {
            }
            column(OnlyWithBalance; only_with_balance_)
            {
            }
            column(PeriodStartDate; PeriodStartDate)
            {
            }
            column(STRSUBSTNO___1___2__PeriodStartDate_PeriodEndDate_; STRSUBSTNO('%1..%2', PeriodStartDate, PeriodEndDate))
            {
            }
            column(FiscalYearStartDate; FiscalYearStartDate)
            {
            }
            column(STRSUBSTNO___1___2__FiscalYearStartDate_PeriodEndDate_; STRSUBSTNO('%1..%2', FiscalYearStartDate, PeriodEndDate))
            {
            }
            column(PeriodEndDate; PeriodEndDate)
            {
            }
            column(PrintDetail; PrintDetail_)
            {
            }
            column(Entity__No__; "No.")
            {
            }
            column(Entity_Name; Name)
            {
            }
            column(PeriodBeginBalance; PeriodBeginBalance)
            {
            }
            column(PeriodDebitAmt; PeriodDebitAmt)
            {
            }
            column(PeriodCreditAmt; PeriodCreditAmt)
            {
            }
            column(YTDBeginBalance; YTDBeginBalance)
            {
            }
            column(YTDDebitAmt; YTDDebitAmt)
            {
            }
            column(YTDCreditAmt; YTDCreditAmt)
            {
            }
            column(YTDTotal; YTDTotal)
            {
            }
            column(PeriodBeginBalance_Control1000000037; PeriodBeginBalance)
            {
            }
            column(PeriodDebitAmt_Control1000000038; PeriodDebitAmt)
            {
            }
            column(PeriodCreditAmt_Control1000000039; PeriodCreditAmt)
            {
            }
            column(YTDBeginBalance_Control1000000040; YTDBeginBalance)
            {
            }
            column(YTDDebitAmt_Control1000000041; YTDDebitAmt)
            {
            }
            column(YTDCreditAmt_Control1000000042; YTDCreditAmt)
            {
            }
            column(YTDTotal_Control1000000043; YTDTotal)
            {
            }
            column(Entities_Trial_BalanceCaption; Entities_Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Values_in_LCYCaption; Values_in_LCYCaptionLbl)
            {
            }
            column(Only_Entities_with_entries_in_the_period_Caption; Only_Entities_with_entries_in_the_period_CaptionLbl)
            {
            }
            column(Entity__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Entity_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(Fiscal_Year_To_DateCaption; Fiscal_Year_To_DateCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000022; EmptyStringCaption_Control1000000022Lbl)
            {
            }
            column(Initial_BalanceCaption; Initial_BalanceCaptionLbl)
            {
            }
            column(Period_BalanceCaption; Period_BalanceCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(CreditCaption_Control1000000029; CreditCaption_Control1000000029Lbl)
            {
            }
            column(DebitCaption_Control1000000030; DebitCaption_Control1000000030Lbl)
            {
            }
            column(Period_BalanceCaption_Control1000000031; Period_BalanceCaption_Control1000000031Lbl)
            {
            }
            column(Initial_BalanceCaption_Control1000000032; Initial_BalanceCaption_Control1000000032Lbl)
            {
            }
            column(Final_BalanceCaption; Final_BalanceCaptionLbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(Entity_Customer_No_; "Customer No.")
            {
            }
            column(Entity_Vendor_No_; "Vendor No.")
            {
            }
            dataitem(DataItem6836; 18)
            {
                DataItemLink = "Entity No." = FIELD("No.");
                DataItemTableView = SORTING("No.");
                column(Customer__No__; "No.")
                {
                }
                column(Customer_Name; Name)
                {
                }
                column(CustomerTotals__1; CustomerTotals[1])
                {
                }
                column(CustomerTotals__2; CustomerTotals[2])
                {
                }
                column(CustomerTotals__3; CustomerTotals[3])
                {
                }
                column(CustomerTotals__6; CustomerTotals[6])
                {
                }
                column(CustomerTotals__5; CustomerTotals[5])
                {
                }
                column(CustomerTotals__4; CustomerTotals[4])
                {
                }
                column(CustomerTotals__7; CustomerTotals[7])
                {
                }
                column(Customer_TotalCaption; Customer_TotalCaptionLbl)
                {
                }
                dataitem(DataItem5801; 92)
                {
                    DataItemTableView = SORTING(Code);
                    column(Customer_Posting_Group_Code; Code)
                    {
                    }
                    column(CustPstGrp_PeriodBeginBalance; PeriodBeginBalance)
                    {
                    }
                    column(CustPstGrp_PeriodDebitAmt; PeriodDebitAmt)
                    {
                    }
                    column(CustPstGrp_PeriodCreditAmt; PeriodCreditAmt)
                    {
                    }
                    column(CustPstGrp_YTDBeginBalance; YTDBeginBalance)
                    {
                    }
                    column(CustPstGrp_YTDDebitAmt; YTDDebitAmt)
                    {
                    }
                    column(CustPstGrp_YTDCreditAmt; YTDCreditAmt)
                    {
                    }
                    column(CustPstGrp_YTDTotal; YTDTotal)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        ClearVars();
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(CustomerTotals);
                end;

                trigger OnPreDataItem()
                begin
                    IF NOT PrintDetail_ THEN
                        CurrReport.BREAK();
                end;
            }
            dataitem(DataItem3182; 23)
            {
                DataItemLink = "Entity No." = FIELD("No.");
                DataItemTableView = SORTING("No.");
                column(Vendor__No__; "No.")
                {
                }
                column(Vendor_Name; Name)
                {
                }
                column(VendorTotals_7; VendorTotals[7])
                {
                }
                column(VendorTotals_6; VendorTotals[6])
                {
                }
                column(VendorTotals_5; VendorTotals[5])
                {
                }
                column(VendorTotals_4; VendorTotals[4])
                {
                }
                column(VendorTotals_3; VendorTotals[3])
                {
                }
                column(VendorTotals_2; VendorTotals[2])
                {
                }
                column(VendorTotals_1; VendorTotals[1])
                {
                }
                column(Vendor_TotalCaption; Vendor_TotalCaptionLbl)
                {
                }
                dataitem(DataItem3958; 93)
                {
                    DataItemTableView = SORTING(Code);
                    column(Vendor_Posting_Group_Code; Code)
                    {
                    }
                    column(VendPstGrp_YTDTotal; YTDTotal)
                    {
                    }
                    column(VendPstGrp_YTDCreditAmt; YTDCreditAmt)
                    {
                    }
                    column(VendPstGrp_YTDDebitAmt; YTDDebitAmt)
                    {
                    }
                    column(VendPstGrp_YTDBeginBalance; YTDBeginBalance)
                    {
                    }
                    column(VendPstGrp_PeriodCreditAmt; PeriodCreditAmt)
                    {
                    }
                    column(VendPstGrp_PeriodDebitAmt; PeriodDebitAmt)
                    {
                    }
                    column(VendPstGrp_PeriodBeginBalance; PeriodBeginBalance)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        ClearVars();
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(VendorTotals);
                end;

                trigger OnPostDataItem()
                begin
                    ClearVars();
                end;

                trigger OnPreDataItem()
                begin
                    IF NOT PrintDetail_ THEN
                        CurrReport.BREAK();
                end;
            }

            trigger OnAfterGetRecord()
            var
                lRecEntityAssociation: Record 31004378;
                Customer: Record Customer;
                Vendor: Record Vendor;
            begin
                ClearVars();

                CLEAR(lRecEntityAssociation);

                lRecEntityAssociation.SETRANGE("Entity VAT Registration No.", "VAT Registration No.");

                IF lRecEntityAssociation.FINDSET() THEN
                    REPEAT
                        CLEAR(Customer);
                        CLEAR(Vendor);

                        IF lRecEntityAssociation.Type = lRecEntityAssociation.Type::Customer THEN
                            Customer.GET(lRecEntityAssociation."No.");

                        CalcAmountsCustomer(
                          PeriodStartDate, PeriodEndDate,
                          PeriodBeginBalance, PeriodDebitAmt, PeriodCreditAmt, YTDTotal);

                        CalcAmountsCustomer(
                          FiscalYearStartDate, PeriodEndDate,
                          YTDBeginBalance, YTDDebitAmt, YTDCreditAmt, YTDTotal);

                        IF lRecEntityAssociation.Type = lRecEntityAssociation.Type::Vendor THEN
                            Vendor.GET(lRecEntityAssociation."No.");

                        CalcAmountsVendor(
                          PeriodStartDate, PeriodEndDate,
                          PeriodBeginBalance, PeriodDebitAmt, PeriodCreditAmt, YTDTotal);

                        CalcAmountsVendor(
                          FiscalYearStartDate, PeriodEndDate,
                          YTDBeginBalance, YTDDebitAmt, YTDCreditAmt, YTDTotal);

                    UNTIL lRecEntityAssociation.NEXT() = 0;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");

                CurrReport.CREATETOTALS(PeriodBeginBalance, PeriodDebitAmt, PeriodCreditAmt, YTDBeginBalance, YTDDebitAmt, YTDCreditAmt, YTDTotal);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(only_with_balance; only_with_balance_)
                    {
                        Caption = 'Show Only Entries with Balance';
                    }
                    field(PrintDetail; PrintDetail_)
                    {
                        Caption = 'Print Detail';
                        Visible = false;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        Entity: Record Entity;
    begin
        WITH Entity DO BEGIN
            PeriodFilter := GETFILTER("Date Filter");
            PeriodStartDate := GETRANGEMIN("Date Filter");
            PeriodEndDate := GETRANGEMAX("Date Filter");
            SETRANGE("Date Filter");
            CustFilter := GETFILTERS();
            SETRANGE("Date Filter", PeriodStartDate, PeriodEndDate);
            AccountingPeriod.SETRANGE("Starting Date", 0D, PeriodEndDate);
            AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
            IF AccountingPeriod.FIND('+') THEN
                FiscalYearStartDate := AccountingPeriod."Starting Date"
            ELSE
                ERROR(Text000Lbl, AccountingPeriod.FIELDCAPTION("Starting Date"), AccountingPeriod.TABLECAPTION());
            FiscalYearFilter := FORMAT(FiscalYearStartDate) + '..' + FORMAT(PeriodEndDate);
        END;

        CompanyInfo.GET();
    end;

    var
        AccountingPeriod: Record 50;
        CompanyInfo: Record 79;
        LastFieldNo: Integer;
        only_with_balance_: Boolean;
        PrintDetail_: Boolean;
        PeriodBeginBalance: Decimal;
        PeriodDebitAmt: Decimal;
        PeriodCreditAmt: Decimal;
        YTDBeginBalance: Decimal;
        YTDDebitAmt: Decimal;
        YTDCreditAmt: Decimal;
        YTDTotal: Decimal;
        CustomerTotals: array[7] of Decimal;
        VendorTotals: array[7] of Decimal;
        PeriodFilter: Text[250];
        FiscalYearFilter: Text[250];
        CustFilter: Text[1024];
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        FiscalYearStartDate: Date;
        Text000Lbl: Label 'It was not possible to find a %1 in %2.';
        Text003Lbl: Label 'Period: %1..%2';
        Entities_Trial_BalanceCaptionLbl: Label 'Entities Trial Balance';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Values_in_LCYCaptionLbl: Label 'Values in LCY';
        Only_Entities_with_entries_in_the_period_CaptionLbl: Label 'Only Entities with entries in the period.';
        PeriodCaptionLbl: Label 'Period';
        Fiscal_Year_To_DateCaptionLbl: Label 'Fiscal Year To Date';
        EmptyStringCaptionLbl: Label '.';
        EmptyStringCaption_Control1000000022Lbl: Label '.';
        Initial_BalanceCaptionLbl: Label 'Initial Balance';
        Period_BalanceCaptionLbl: Label 'Period Balance';
        DebitCaptionLbl: Label 'Debit';
        CreditCaptionLbl: Label 'Credit';
        CreditCaption_Control1000000029Lbl: Label 'Credit';
        DebitCaption_Control1000000030Lbl: Label 'Debit';
        Period_BalanceCaption_Control1000000031Lbl: Label 'Period Balance';
        Initial_BalanceCaption_Control1000000032Lbl: Label 'Initial Balance';
        Final_BalanceCaptionLbl: Label 'Final Balance';
        TOTALCaptionLbl: Label 'TOTAL';
        Customer_TotalCaptionLbl: Label 'Customer Total';
        Vendor_TotalCaptionLbl: Label 'Vendor Total';

    procedure ClearVars()
    begin
        // Clear Vars
        PeriodBeginBalance := 0;
        PeriodDebitAmt := 0;
        PeriodCreditAmt := 0;
        YTDBeginBalance := 0;
        YTDDebitAmt := 0;
        YTDCreditAmt := 0;
        YTDTotal := 0;
    end;

    local procedure CalcAmountsCustomer(DateFrom: Date; DateTo: Date; var BeginBalance: Decimal; var DebitAmt: Decimal; var CreditAmt: Decimal; var TotalBalance: Decimal)
    var
        DtlCustLedgEntry: Record 379;
        lRecCustLedgEntry: Record 21;
        Customer: Record Customer;

    begin
        // Calc Amount Customer

        Customer.SETRANGE("Date Filter", 0D, DateFrom - 1);
        Customer.CALCFIELDS("Net Change (LCY)");
        BeginBalance := Customer."Net Change (LCY)";

        WITH DtlCustLedgEntry DO BEGIN
            SETCURRENTKEY("Customer No.", "Posting Date", "Entry Type", "Currency Code", "Excluded from calculation");
            SETRANGE("Customer No.", Customer."No.");

            IF NOT PrintDetail_ THEN BEGIN

                IF FINDSET() THEN
                    REPEAT
                        DebitAmt += "Amount (LCY)";
                    UNTIL NEXT() = 0;
                TotalBalance := DebitAmt - CreditAmt;

            END
            ELSE BEGIN
                IF FINDSET() THEN
                    REPEAT
                        CLEAR(lRecCustLedgEntry);
                        lRecCustLedgEntry.GET("Cust. Ledger Entry No.");
                        IF lRecCustLedgEntry."Customer Posting Group" = "Customer Posting Group" THEN
                            DebitAmt += "Amount (LCY)";

                    UNTIL NEXT() = 0;

                TotalBalance := DebitAmt - CreditAmt;
            END;
        END;
    end;

    local procedure CalcAmountsVendor(DateFrom: Date; DateTo: Date; var BeginBalance: Decimal; var DebitAmt: Decimal; var CreditAmt: Decimal; var TotalBalance: Decimal)
    var
        DtlVendLedgEntry: Record 380;
        lRecVendLedgEntry: Record 25;
        Vendor: Record Vendor;
    begin
        // Calc Amounts Vendor

        Vendor.SETRANGE("Date Filter", 0D, DateFrom - 1);
        Vendor.CALCFIELDS("Net Change (LCY)");
        BeginBalance := -Vendor."Net Change (LCY)";

        WITH DtlVendLedgEntry DO BEGIN
            SETCURRENTKEY("Vendor No.", "Posting Date", "Entry Type", "Currency Code");
            SETRANGE("Vendor No.", Vendor."No.");

            IF NOT PrintDetail_ THEN BEGIN
                IF FINDSET() THEN
                    REPEAT
                        CreditAmt += -"Amount (LCY)";
                    UNTIL NEXT() = 0;
                TotalBalance := DebitAmt - CreditAmt;

            END
            ELSE BEGIN
                IF FINDSET() THEN
                    REPEAT
                        CLEAR(lRecVendLedgEntry);
                        lRecVendLedgEntry.GET("Vendor Ledger Entry No.");
                        IF lRecVendLedgEntry."Vendor Posting Group" = "Vendor Posting Group" THEN
                            CreditAmt += -"Amount (LCY)";
                    UNTIL NEXT() = 0;
                TotalBalance := DebitAmt - CreditAmt;
            END;
        END;
    end;
}

