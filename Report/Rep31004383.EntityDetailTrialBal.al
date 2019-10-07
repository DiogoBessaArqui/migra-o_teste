report 31004383 "Entity - Detail Trial Bal."
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Report </Comment>
    // //[*]</LMS>
    DefaultLayout = RDLC;
    RDLCLayout = './Entity - Detail Trial Bal..rdlc';

    Caption = 'Entity - Detail Trial Bal.';
    Description = 'ID:ENTITY.00.01.01.00';

    dataset
    {
        dataitem(DataItem3901; 31004376)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(COMPANYNAME; COMPANYNAME())
            {
            }
            column(STRSUBSTNO_Text000Lbl_EntityDateFilter_; STRSUBSTNO(Text000Lbl, EntityDateFilter))
            {
            }
            column(USERID; USERID())
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY(), 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(Customer_TABLECAPTION__________CustFilter; Customer.TABLECAPTION() + ': ' + CustFilter)
            {
            }
            column(AmountCaption; AmountCaption)
            {
            }
            column(RemainingAmtCaption; RemainingAmtCaption)
            {
            }
            column(Entity_Name; Name)
            {
            }
            column(Entity__No__; "No.")
            {
            }
            column(Customer___Detail_Trial_Bal_Caption; Customer___Detail_Trial_Bal_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(This_report_also_includes_entities_that_only_have_balances_Caption; This_report_also_includes_entities_that_only_have_balances_CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; "Cust. Ledger Entry".FIELDCAPTION("Posting Date"))
            {
            }
            column(Cust__Ledger_Entry__Document_Type_Caption; Cust__Ledger_Entry__Document_Type_CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; "Cust. Ledger Entry".FIELDCAPTION("Document No."))
            {
            }
            column(Cust__Ledger_Entry_DescriptionCaption; "Cust. Ledger Entry".FIELDCAPTION(Description))
            {
            }
            column(Cust__Ledger_Entry__Applies_to_Doc__No__Caption; Cust__Ledger_Entry__Applies_to_Doc__No__CaptionLbl)
            {
            }
            column(CustEntryDueDateCaption; CustEntryDueDateCaptionLbl)
            {
            }
            column(CustBalanceLCY_Control56Caption; CustBalanceLCY_Control56CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Entry_No__Caption; "Cust. Ledger Entry".FIELDCAPTION("Entry No."))
            {
            }
            column(EntityCaption; EntityCaptionLbl)
            {
            }
            column(Entity_Customer_No_; "Customer No.")
            {
            }
            column(Entity_Vendor_No_; "Vendor No.")
            {
            }
            dataitem(DataItem1000000037; 31004378)
            {
                DataItemLink = "Entity VAT Registration No." = FIELD("VAT Registration No.");
                dataitem(DataItem6836; 18)
                {
                    DataItemLink = "VAT Registration No." = FIELD("VAT Registration No.");
                    DataItemTableView = SORTING("No.");
                    PrintOnlyIfDetail = true;
                    column(Customer__No__; "No.")
                    {
                    }
                    column(Customer_Name; Name)
                    {
                    }
                    column(StartBalanceLCY; StartBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(StartBalAdjLCY; StartBalAdjLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(CustBalanceLCY; CustBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(StartBalanceLCY___StartBalAdjLCY____Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding; StartBalanceLCY + StartBalAdjLCY + "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }
                    column(StartBalanceLCY_Control47; StartBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding; "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }
                    column(StartBalAdjLCY_Control67; StartBalAdjLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(StartBalanceLCY___StartBalAdjLCY; StartBalanceLCY + StartBalAdjLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding_Control69; "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }
                    column(StartBalanceLCY____Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding; StartBalanceLCY + "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }
                    column(StartBalanceLCY_Control71; StartBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(CustomerCaption; CustomerCaptionLbl)
                    {
                    }
                    column(Adj__of_Opening_BalanceCaption; Adj__of_Opening_BalanceCaptionLbl)
                    {
                    }
                    column(Total__LCY__Before_PeriodCaption; Total__LCY__Before_PeriodCaptionLbl)
                    {
                    }
                    column(Total__LCY_Caption; Total__LCY_CaptionLbl)
                    {
                    }
                    column(Total_Adj__of_Opening_BalanceCaption; Total_Adj__of_Opening_BalanceCaptionLbl)
                    {
                    }
                    column(Total__LCY_Caption_Control30; Total__LCY_Caption_Control30Lbl)
                    {
                    }
                    column(Total__LCY__Before_PeriodCaption_Control16; Total__LCY__Before_PeriodCaption_Control16Lbl)
                    {
                    }
                    column(Customer_Date_Filter; "Date Filter")
                    {
                    }
                    column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
                    {
                    }
                    column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
                    {
                    }
                    dataitem(DataItem8503; 21)
                    {
                        DataItemLink = "Customer No." = FIELD("No."),
                                       "Posting Date" = FIELD("Date Filter"),
                                       "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                       "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                       "Date Filter" = FIELD("Date Filter");
                        DataItemTableView = SORTING("Customer No.", "Posting Date");
                        column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY__; StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
                        {
                        }
                        column(Cust__Ledger_Entry__Document_Type_; "Document Type")
                        {
                        }
                        column(Cust__Ledger_Entry__Document_No__; "Document No.")
                        {
                        }
                        column(Cust__Ledger_Entry_Description; Description)
                        {
                        }
                        column(CustAmount; CustAmount)
                        {
                            AutoFormatExpression = CustCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(CustRemainAmount; CustRemainAmount)
                        {
                            AutoFormatExpression = CustCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Cust__Ledger_Entry__Applies_to_Doc__No__; "Applies-to Doc. No.")
                        {
                        }
                        column(CustEntryDueDate; CustEntryDueDate)
                        {
                        }
                        column(Cust__Ledger_Entry__Entry_No__; "Entry No.")
                        {
                        }
                        column(CustCurrencyCode; CustCurrencyCode)
                        {
                        }
                        column(CustBalanceLCY_Control56; CustBalanceLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY___Control59; StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)")
                        {
                            AutoFormatType = 1;
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control46; ContinuedCaption_Control46Lbl)
                        {
                        }
                        column(Cust__Ledger_Entry_Customer_No_; "Customer No.")
                        {
                        }
                        column(Cust__Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                        {
                        }
                        column(Cust__Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                        {
                        }
                        column(Cust__Ledger_Entry_Date_Filter; "Date Filter")
                        {
                        }
                        dataitem(DataItem6942; 379)
                        {
                            DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                            DataItemTableView = SORTING("Cust. Ledger Entry No.", "Entry Type", "Posting Date")
                                                WHERE("Entry Type" = CONST("Correction of Remaining Amount"));
                            column(Cust__Ledger_Entry___Document_No__; "Cust. Ledger Entry"."Document No.")
                            {
                            }
                            column(Cust__Ledger_Entry___Document_Type_; "Cust. Ledger Entry"."Document Type")
                            {
                            }
                            column(Detailed_Cust__Ledg__Entry__Entry_Type_; "Entry Type")
                            {
                            }
                            column(Correction; Correction)
                            {
                                AutoFormatType = 1;
                            }
                            column(CustBalanceLCY_Control61; CustBalanceLCY)
                            {
                                AutoFormatType = 1;
                            }
                            column(Detailed_Cust__Ledg__Entry_Entry_No_; "Entry No.")
                            {
                            }
                            column(Detailed_Cust__Ledg__Entry_Cust__Ledger_Entry_No_; "Cust. Ledger Entry No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                Correction := Correction + "Amount (LCY)";
                                CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETFILTER("Posting Date", EntityDateFilter);
                            end;
                        }
                        dataitem("Detailed Cust. Ledg. Entry2"; 379)
                        {
                            DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                            DataItemTableView = SORTING("Cust. Ledger Entry No.", "Entry Type", "Posting Date")
                                                WHERE("Entry Type" = CONST("Appln. Rounding"));
                            column(Cust__Ledger_Entry___Document_Type__Control29; "Cust. Ledger Entry"."Document Type")
                            {
                            }
                            column(Cust__Ledger_Entry___Document_No___Control31; "Cust. Ledger Entry"."Document No.")
                            {
                            }
                            column(Detailed_Cust__Ledg__Entry2__Entry_Type_; "Entry Type")
                            {
                            }
                            column(ApplicationRounding; ApplicationRounding)
                            {
                                AutoFormatType = 1;
                            }
                            column(CustBalanceLCY_Control73; CustBalanceLCY)
                            {
                                AutoFormatType = 1;
                            }
                            column(Detailed_Cust__Ledg__Entry2_Entry_No_; "Entry No.")
                            {
                            }
                            column(Detailed_Cust__Ledg__Entry2_Cust__Ledger_Entry_No_; "Cust. Ledger Entry No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                ApplicationRounding := ApplicationRounding + "Amount (LCY)";
                                CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                                IF CONFIRM('%1 %2', TRUE, Text001Lbl, ApplicationRounding) THEN;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETFILTER("Posting Date", EntityDateFilter);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            CALCFIELDS(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)");

                            CustLedgEntryExists := TRUE;
                            IF PrintAmountsInLCY THEN BEGIN
                                CustAmount := "Amount (LCY)";
                                CustRemainAmount := "Remaining Amt. (LCY)";
                                CustCurrencyCode := '';
                            END ELSE BEGIN
                                CustAmount := Amount;
                                CustRemainAmount := "Remaining Amount";
                                CustCurrencyCode := "Currency Code";
                            END;
                            CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                            IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                                CustEntryDueDate := 0D
                            ELSE
                                CustEntryDueDate := "Due Date";
                        end;

                        trigger OnPreDataItem()
                        begin
                            CustLedgEntryExists := FALSE;
                            CurrReport.CREATETOTALS(CustAmount, "Amount (LCY)");
                        end;
                    }
                    dataitem(DataItem5444; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(Customer_Name_Control48; Customer.Name)
                        {
                        }
                        column(CustBalanceLCY_; CustBalanceLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(Customer_Name_Control15; Customer.Name)
                        {
                        }
                        column(CustBalanceLCY_StartBalanceLCY_StartBalAdjLCY; CustBalanceLCY - StartBalanceLCY - StartBalAdjLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(CustBalanceLCY_Control63; CustBalanceLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(Integer_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF NOT CustLedgEntryExists AND ((StartBalanceLCY = 0) OR ExcludeBalanceOnly) THEN BEGIN
                                StartBalanceLCY := 0;
                                CurrReport.SKIP();
                            END;

                            EntityBalance := CustBalanceLCY;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        Customer: Record Customer;
                        "Detailed Cust. Ledg. Entry": Record "Detailed Cust. Ledg. Entry";
                    begin
                        StartBalanceLCY := 0;
                        StartBalAdjLCY := 0;
                        IF EntityDateFilter <> '' THEN BEGIN
                            IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                                SETRANGE("Date Filter", 0D, GETRANGEMIN("Date Filter") - 1);
                                CALCFIELDS("Net Change (LCY)");
                                StartBalanceLCY := "Net Change (LCY)";
                                EntityStartBalance := StartBalanceLCY;
                            END;
                            SETFILTER("Date Filter", EntityDateFilter);
                            CALCFIELDS("Net Change (LCY)");
                            StartBalAdjLCY := "Net Change (LCY)";
                            CustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                            CustLedgEntry.SETRANGE("Customer No.", Customer."No.");
                            CustLedgEntry.SETFILTER("Posting Date", EntityDateFilter);
                            IF CustLedgEntry.FIND('-') THEN
                                REPEAT
                                    CustLedgEntry.SETFILTER("Date Filter", EntityDateFilter);
                                    CustLedgEntry.CALCFIELDS("Amount (LCY)");
                                    StartBalAdjLCY := StartBalAdjLCY - CustLedgEntry."Amount (LCY)";
                                    "Detailed Cust. Ledg. Entry".SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                                    "Detailed Cust. Ledg. Entry".SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                                    "Detailed Cust. Ledg. Entry".SETFILTER("Posting Date", EntityDateFilter);
                                    IF "Detailed Cust. Ledg. Entry".FIND('-') THEN
                                        REPEAT
                                            StartBalAdjLCY := StartBalAdjLCY - "Detailed Cust. Ledg. Entry"."Amount (LCY)";
                                        UNTIL "Detailed Cust. Ledg. Entry".NEXT() = 0;
                                    "Detailed Cust. Ledg. Entry".RESET();
                                UNTIL CustLedgEntry.NEXT() = 0;
                        END;
                        // CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalanceLCY = 0);
                        CustBalanceLCY := StartBalanceLCY + StartBalAdjLCY
                    end;

                    trigger OnPreDataItem()
                    var
                        Customer: Record Customer;
                        Entity: Record Entity;
                        "Cust. Ledger Entry": Record "Cust. Ledger Entry";
                    begin
                        CurrReport.CREATETOTALS("Cust. Ledger Entry"."Amount (LCY)", StartBalanceLCY, StartBalAdjLCY, Correction, ApplicationRounding);

                        Customer.SETFILTER("Date Filter", Entity.GETFILTER("Date Filter"));
                    end;
                }
                dataitem(DataItem3182; 23)
                {
                    DataItemLink = "VAT Registration No." = FIELD("VAT Registration No.");
                    DataItemTableView = SORTING("No.");
                    column(Vendor_Name; Name)
                    {
                    }
                    column(Vendor__No__; "No.")
                    {
                    }
                    column(StartBalanceLCY_Control1000000018; StartBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(CustBalanceLCY_Control1000000019; CustBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(StartBalAdjLCY_Control1000000020; StartBalAdjLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VendorCaption; VendorCaptionLbl)
                    {
                    }
                    column(Adj__of_Opening_BalanceCaption_Control1000000021; Adj__of_Opening_BalanceCaption_Control1000000021Lbl)
                    {
                    }
                    column(Vendor_Date_Filter; "Date Filter")
                    {
                    }
                    column(Vendor_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
                    {
                    }
                    column(Vendor_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
                    {
                    }
                    dataitem(DataItem4114; 25)
                    {
                        DataItemLink = "Vendor No." = FIELD("No."),
                                       "Posting Date" = FIELD("Date Filter"),
                                       "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                       "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                       "Date Filter" = FIELD("Date Filter");
                        DataItemTableView = SORTING("Vendor No.", "Posting Date");
                        column(Vendor_Ledger_Entry_Description; Description)
                        {
                        }
                        column(Vendor_Ledger_Entry__Document_No__; "Document No.")
                        {
                        }
                        column(Vendor_Ledger_Entry__Document_Type_; "Document Type")
                        {
                        }
                        column(Vendor_Ledger_Entry__Posting_Date_; "Posting Date")
                        {
                        }
                        column(VendCurrencyCode; VendCurrencyCode)
                        {
                        }
                        column(VendAmount; VendAmount)
                        {
                            AutoFormatExpression = VendCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VendRemainAmount; VendRemainAmount)
                        {
                            AutoFormatExpression = VendCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VendBalanceLCY; VendBalanceLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(Vendor_Ledger_Entry__Applies_to_Doc__No__; "Applies-to Doc. No.")
                        {
                        }
                        column(VendEntryDueDate; VendEntryDueDate)
                        {
                        }
                        column(Vendor_Ledger_Entry__Entry_No__; "Entry No.")
                        {
                        }
                        column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
                        {
                        }
                        column(Vendor_Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                        {
                        }
                        column(Vendor_Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                        {
                        }
                        column(Vendor_Ledger_Entry_Date_Filter; "Date Filter")
                        {
                        }
                        dataitem(DataItem2149; 380)
                        {
                            DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                            DataItemTableView = SORTING("Vendor Ledger Entry No.", "Entry Type", "Posting Date")
                                                WHERE("Entry Type" = CONST("Correction of Remaining Amount"));
                            column(Vendor_Ledger_Entry___Document_Type_; "Vendor Ledger Entry"."Document Type")
                            {
                            }
                            column(Vendor_Ledger_Entry___Document_No__; "Vendor Ledger Entry"."Document No.")
                            {
                            }
                            column(Detailed_Vendor_Ledg__Entry__Entry_Type_; "Entry Type")
                            {
                            }
                            column(Correction_Control1000000025; Correction)
                            {
                                AutoFormatType = 1;
                            }
                            column(VendBalanceLCY_Control1000000026; VendBalanceLCY)
                            {
                                AutoFormatType = 1;
                            }
                            column(Detailed_Vendor_Ledg__Entry_Entry_No_; "Entry No.")
                            {
                            }
                            column(Detailed_Vendor_Ledg__Entry_Vendor_Ledger_Entry_No_; "Vendor Ledger Entry No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                Correction := Correction + "Amount (LCY)";
                                VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETFILTER("Posting Date", EntityDateFilter);
                            end;
                        }
                        dataitem("Detailed Vendor Ledg. Entry2"; 380)
                        {
                            DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                            DataItemTableView = SORTING("Vendor Ledger Entry No.", "Entry Type", "Posting Date")
                                                WHERE("Entry Type" = CONST("Appln. Rounding"));
                            column(Detailed_Vendor_Ledg__Entry2__Entry_Type_; "Entry Type")
                            {
                            }
                            column(ApplicationRounding_Control1000000028; ApplicationRounding)
                            {
                                AutoFormatType = 1;
                            }
                            column(VendBalanceLCY_Control1000000029; VendBalanceLCY)
                            {
                                AutoFormatType = 1;
                            }
                            column(Vendor_Ledger_Entry___Document_No___Control1000000030; "Vendor Ledger Entry"."Document No.")
                            {
                            }
                            column(Vendor_Ledger_Entry___Document_Type__Control1000000031; "Vendor Ledger Entry"."Document Type")
                            {
                            }
                            column(Detailed_Vendor_Ledg__Entry2_Entry_No_; "Entry No.")
                            {
                            }
                            column(Detailed_Vendor_Ledg__Entry2_Vendor_Ledger_Entry_No_; "Vendor Ledger Entry No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                ApplicationRounding := ApplicationRounding + "Amount (LCY)";
                                VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETFILTER("Posting Date", EntityDateFilter);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            CALCFIELDS(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)");

                            VendLedgEntryExists := TRUE;
                            IF PrintAmountsInLCY THEN BEGIN
                                VendAmount := "Amount (LCY)";
                                VendRemainAmount := "Remaining Amt. (LCY)";
                                VendCurrencyCode := '';
                            END ELSE BEGIN
                                VendAmount := Amount;
                                VendRemainAmount := "Remaining Amount";
                                VendCurrencyCode := "Currency Code";
                            END;
                            VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                            IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                                VendEntryDueDate := 0D
                            ELSE
                                VendEntryDueDate := "Due Date";
                        end;

                        trigger OnPreDataItem()

                        begin
                            VendLedgEntryExists := FALSE;
                            CurrReport.CREATETOTALS(VendAmount, "Amount (LCY)");
                        end;
                    }
                    dataitem(Integer2; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(Vendor_Name_Control1000000032; Vendor.Name)
                        {
                        }
                        column(VendBalanceLCY_; VendBalanceLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(Vendor_Name_Control1000000034; Vendor.Name)
                        {
                        }
                        column(CustBalanceLCY_StartBalanceLCY_StartBalAdjLCY_Control1000000035; CustBalanceLCY - StartBalanceLCY - StartBalAdjLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VendBalanceLCY_Control1000000036; VendBalanceLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(Integer2_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF NOT VendLedgEntryExists AND ((StartBalanceLCY = 0) OR ExcludeBalanceOnly) THEN BEGIN
                                StartBalanceLCY := 0;
                                CurrReport.SKIP();
                            END;

                            EntityBalance -= ABS(VendBalanceLCY);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        Vendor: Record Vendor;
                        "Detailed Vendor Ledg. Entry": Record "Detailed Vendor Ledg. Entry";

                    begin
                        StartBalanceLCY := 0;
                        StartBalAdjLCY := 0;
                        IF EntityDateFilter <> '' THEN BEGIN
                            IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                                SETRANGE("Date Filter", 0D, GETRANGEMIN("Date Filter") - 1);
                                CALCFIELDS("Net Change (LCY)");
                                StartBalanceLCY := -"Net Change (LCY)";
                                EntityStartBalance += StartBalanceLCY;

                            END;
                            SETFILTER("Date Filter", EntityDateFilter);
                            CALCFIELDS("Net Change (LCY)");
                            StartBalAdjLCY := -"Net Change (LCY)";
                            VendorLedgerEntry.SETCURRENTKEY("Vendor No.", "Posting Date");
                            VendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                            VendorLedgerEntry.SETFILTER("Posting Date", EntityDateFilter);
                            IF VendorLedgerEntry.FIND('-') THEN
                                REPEAT
                                    VendorLedgerEntry.SETFILTER("Date Filter", EntityDateFilter);
                                    VendorLedgerEntry.CALCFIELDS("Amount (LCY)");
                                    StartBalAdjLCY := StartBalAdjLCY - VendorLedgerEntry."Amount (LCY)";
                                    "Detailed Vendor Ledg. Entry".SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type", "Posting Date");
                                    "Detailed Vendor Ledg. Entry".SETRANGE("Vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
                                    "Detailed Vendor Ledg. Entry".SETFILTER("Posting Date", EntityDateFilter);
                                    IF "Detailed Vendor Ledg. Entry".FIND('-') THEN
                                        REPEAT
                                            StartBalAdjLCY := StartBalAdjLCY - "Detailed Vendor Ledg. Entry"."Amount (LCY)";
                                        UNTIL "Detailed Vendor Ledg. Entry".NEXT() = 0;
                                    "Detailed Vendor Ledg. Entry".RESET();
                                UNTIL VendorLedgerEntry.NEXT() = 0;
                        END;
                        //CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalanceLCY = 0);
                        VendBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
                    end;

                    trigger OnPreDataItem()
                    var
                        Vendor: Record Vendor;
                        Entity: Record Entity;
                        "Vendor Ledger Entry": Record "Vendor Ledger Entry";

                    begin
                        CurrReport.CREATETOTALS("Vendor Ledger Entry"."Amount (LCY)", StartBalanceLCY, Correction, ApplicationRounding);

                        Vendor.SETFILTER("Date Filter", Entity.GETFILTER("Date Filter"));
                    end;
                }
                dataitem(Integer3; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(EntityBalance; EntityBalance)
                    {
                        AutoFormatType = 1;
                    }
                    column(EntityStartBalance; EntityStartBalance)
                    {
                        AutoFormatType = 1;
                    }
                    column(Total__LCY_Caption_Control1000000046; Total__LCY_Caption_Control1000000046Lbl)
                    {
                    }
                    column(Total__LCY__Before_PeriodCaption_Control1000000043; Total__LCY__Before_PeriodCaption_Control1000000043Lbl)
                    {
                    }
                    column(Integer3_Number; Number)
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                EntityBalance := 0;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;

                CurrReport.CREATETOTALS(StartBalanceLCY, Correction, ApplicationRounding);
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        CustFilter := Customer.GETFILTERS();
        EntityDateFilter := Entity.GETFILTER("Date Filter");
        WITH "Cust. Ledger Entry" DO
            IF PrintAmountsInLCY THEN BEGIN
                AmountCaption := FIELDCAPTION("Amount (LCY)");
                RemainingAmtCaption := FIELDCAPTION("Remaining Amt. (LCY)");
            END ELSE BEGIN
                AmountCaption := FIELDCAPTION(Amount);
                RemainingAmtCaption := FIELDCAPTION("Remaining Amount");
            END;
    end;

    var
        Customer: Record Customer;
        "Cust. Ledger Entry": Record "Cust. Ledger Entry";
        "Vendor Ledger Entry": Record "Vendor Ledger Entry";

        Vendor: Record "Vendor";

        CustLedgEntry: Record 21;
        VendorLedgerEntry: Record 25;
        Text000Lbl: Label 'Period: %1';
        PrintAmountsInLCY: Boolean;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        CustFilter: Text[250];
        EntityDateFilter: Text[30];
        AmountCaption: Text[30];
        RemainingAmtCaption: Text[30];
        CustAmount: Decimal;
        CustRemainAmount: Decimal;
        CustBalanceLCY: Decimal;
        VendBalanceLCY: Decimal;
        CustCurrencyCode: Code[10];
        CustEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        CustLedgEntryExists: Boolean;
        Text001Lbl: Label 'Appln Rounding:';
        VendAmount: Decimal;
        VendRemainAmount: Decimal;
        VendEntryDueDate: Date;
        VendLedgEntryExists: Boolean;
        VendCurrencyCode: Code[10];
        EntityStartBalance: Decimal;
        EntityBalance: Decimal;
        Customer___Detail_Trial_Bal_CaptionLbl: Label 'Customer - Detail Trial Bal.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        This_report_also_includes_entities_that_only_have_balances_CaptionLbl: Label 'This report also includes entities that only have balances.';
        Cust__Ledger_Entry__Document_Type_CaptionLbl: Label 'Document Type';
        Cust__Ledger_Entry__Applies_to_Doc__No__CaptionLbl: Label 'Applies-to Doc. No.';
        CustEntryDueDateCaptionLbl: Label 'Due Date';
        CustBalanceLCY_Control56CaptionLbl: Label 'Balance (LCY)';
        EntityCaptionLbl: Label 'Entity';
        CustomerCaptionLbl: Label 'Customer';
        Adj__of_Opening_BalanceCaptionLbl: Label 'Adj. of Opening Balance';
        Total__LCY__Before_PeriodCaptionLbl: Label 'Total (LCY) Before Period';
        Total__LCY_CaptionLbl: Label 'Total (LCY)';
        Total_Adj__of_Opening_BalanceCaptionLbl: Label 'Total Adj. of Opening Balance';
        Total__LCY_Caption_Control30Lbl: Label 'Total (LCY)';
        Total__LCY__Before_PeriodCaption_Control16Lbl: Label 'Total (LCY) Before Period';
        ContinuedCaptionLbl: Label 'Continued';
        ContinuedCaption_Control46Lbl: Label 'Continued';
        VendorCaptionLbl: Label 'Vendor';
        Adj__of_Opening_BalanceCaption_Control1000000021Lbl: Label 'Adj. of Opening Balance';
        Total__LCY_Caption_Control1000000046Lbl: Label 'Total (LCY)';
        Total__LCY__Before_PeriodCaption_Control1000000043Lbl: Label 'Total (LCY) Before Period';
}

