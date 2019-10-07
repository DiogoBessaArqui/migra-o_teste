report 31004381 "Entity Receipt"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Report </Comment>
    // //[*]</LMS>

    DefaultLayout = RDLC;
    RDLCLayout = './Entity Receipt.rdlc';

    Caption = 'Entity Receipt';
    Description = 'ID:ENTITY.00.01.01.00';


    dataset
    {
        dataitem(DataItem3901; 31004376)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Customer No. EntityAss";
            column(Entity_No_; "No.")
            {
            }
            column(Entity_Customer_No_; "Customer No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }

            dataitem(DataItem8503; 21)

            {
                DataItemLink = "Customer No." = FIELD("Customer No. EntityAss");
                DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code")
                                    WHERE("Document Type" = FILTER(Payment));
                RequestFilterFields = "Document No.";


                column(Cust__Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(CurrReport_PAGENO; CurrReport.PAGENO())
                {
                }
                column(gtxtCustName; gtxtCustName)
                {
                }
                column(Entity_Name_Entity__Name_2_; Entity.Name + Entity."Name 2")
                {
                }
                column(Entity_Address; Entity.Address)
                {
                }
                column(Entity__Address_2_; Entity."Address 2")
                {
                }
                column(Entity__Postal_Code__Entity_City; Entity."Postal Code" + Entity.City)
                {
                }
                column(Entity__No__; Entity."No.")
                {
                }
                column(company_address_1_; company_address[1])
                {
                }
                column(company_address_2_; company_address[2])
                {
                }
                column(company_address_3_; company_address[3])
                {
                }
                column(company_address_4_; company_address[4])
                {
                }
                column(company_address_5_; company_address[5])
                {
                }
                column(company_address_6_; company_address[6])
                {
                }
                column(company_address_7_; company_address[7])
                {
                }
                column(company_address_8_; company_address[8])
                {
                }
                column(Cust__Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Entity_No_Caption; Entity_No_CaptionLbl)
                {
                }
                column(Settlement_DetailCaption; Settlement_DetailCaptionLbl)
                {
                }
                column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Customer_No_; "Customer No.")
                {
                    IncludeCaption = true;
                }
                column(Cust__Ledger_Entry_Document_Type; "Document Type")
                {
                }
                dataitem(DataItem6942; 379)
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"),
                                   "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Document Type", "Document No.", "Customer No.");
                    PrintOnlyIfDetail = true;
                    column(Posting_DateCaption; Posting_DateCaptionLbl)
                    {
                    }
                    column(Document_TypeCaption; Document_TypeCaptionLbl)
                    {
                    }
                    column(Document_No_Caption; Document_No_CaptionLbl)
                    {
                    }
                    column(DescriptionCaption; DescriptionCaptionLbl)
                    {
                    }
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(Original_AmountCaption; Original_AmountCaptionLbl)
                    {
                    }
                    column(Customer_Applied_DocumentsCaption; Customer_Applied_DocumentsCaptionLbl)
                    {
                    }
                    column(Payment_DiscountCaption; Payment_DiscountCaptionLbl)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Document_Type; "Document Type")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Document_No_; "Document No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Cust__Ledger_Entry_No_; "Cust. Ledger Entry No.")
                    {
                    }
                    dataitem(CustLedgerEntry2; 21)
                    {
                        DataItemLink = "Entry No." = FIELD("Cust. Ledger Entry No.");
                        DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code")
                                            WHERE("Document Type" = FILTER(<> Payment));
                        column(CustLedgerEntry2__Original_Amount_; "Original Amount")
                        {
                        }
                        column(Detailed_Cust__Ledg__Entry__Amount; "Detailed Cust. Ledg. Entry".Amount)
                        {
                        }
                        column(CustLedgerEntry2_CustLedgerEntry2__Posting_Date_; CustLedgerEntry2."Posting Date")
                        {
                        }
                        column(CustLedgerEntry2_CustLedgerEntry2__Document_Type_; CustLedgerEntry2."Document Type")
                        {
                        }
                        column(CustLedgerEntry2_CustLedgerEntry2__Document_No__; CustLedgerEntry2."Document No.")
                        {
                        }
                        column(CustLedgerEntry2_CustLedgerEntry2_Description; CustLedgerEntry2.Description)
                        {
                        }
                        column(CustLedgerEntry2_CustLedgerEntry2__Currency_Code_; CustLedgerEntry2."Currency Code")
                        {
                        }
                        column(CustDiscountPP; CustDiscountPP)
                        {
                        }
                        column(CustLedgerEntry2_Entry_No_; "Entry No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            cust_value -= "Detailed Cust. Ledg. Entry".Amount;
                            CLEAR(CustDiscountPP);
                            IF CustLedgerEntry2."Posting Date" < CustLedgerEntry2."Pmt. Discount Date" THEN
                                CustDiscountPP := CustLedgerEntry2."Pmt. Disc. Given (LCY)"
                        end;
                    }
                }
                dataitem(DataItem4114; 25)
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"),
                                   "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code")
                                        WHERE("Document Type" = CONST(Payment));
                    PrintOnlyIfDetail = true;
                    column(AmountCaption_Control1000000031; AmountCaption_Control1000000031Lbl)
                    {
                    }
                    column(Original_AmountCaption_Control1000000032; Original_AmountCaption_Control1000000032Lbl)
                    {
                    }
                    column(DescriptionCaption_Control1000000033; DescriptionCaption_Control1000000033Lbl)
                    {
                    }
                    column(Document_No_Caption_Control1000000035; Document_No_Caption_Control1000000035Lbl)
                    {
                    }
                    column(Posting_DateCaption_Control1000000036; Posting_DateCaption_Control1000000036Lbl)
                    {
                    }
                    column(Document_TypeCaption_Control1000000037; Document_TypeCaption_Control1000000037Lbl)
                    {
                    }
                    column(Vendor_Applied_DocumentsCaption; Vendor_Applied_DocumentsCaptionLbl)
                    {
                    }
                    column(Payment_DiscountCaption_Control1000000030; Payment_DiscountCaption_Control1000000030Lbl)
                    {
                    }
                    column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Vendor_Ledger_Entry_Document_Type; "Document Type")
                    {
                    }
                    column(Vendor_Ledger_Entry_Document_No_; "Document No.")
                    {
                    }
                    column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
                    {
                        IncludeCaption = true;
                    }
                    column(gtxtVendName; gtxtVendName)
                    {
                    }
                    dataitem(DataItem2149; 380)
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("Document No.");
                        DataItemTableView = SORTING("Vendor Ledger Entry No.", "Posting Date", "Document Type");
                        PrintOnlyIfDetail = true;
                        column(Detailed_Vendor_Ledg__Entry_Entry_No_; "Entry No.")
                        {
                        }
                        column(Detailed_Vendor_Ledg__Entry_Document_Type; "Document Type")
                        {
                        }
                        column(Detailed_Vendor_Ledg__Entry_Document_No_; "Document No.")
                        {
                        }
                        column(Detailed_Vendor_Ledg__Entry_Vendor_Ledger_Entry_No_; "Vendor Ledger Entry No.")
                        {
                        }
                        dataitem(VendLedgerEntry; 25)
                        {
                            DataItemLink = "Entry No." = FIELD("Vendor Ledger Entry No.");
                            DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code")
                                                WHERE("Document Type" = FILTER(<> Payment));
                            column(VendLedgerEntry__Original_Amount_; "Original Amount")
                            {
                            }
                            column(Detailed_Vendor_Ledg__Entry__Amount; "Detailed Vendor Ledg. Entry".Amount)
                            {
                            }
                            column(VendLedgerEntry_VendLedgerEntry__Posting_Date_; VendLedgerEntry."Posting Date")
                            {
                            }
                            column(VendLedgerEntry_VendLedgerEntry__Document_Type_; VendLedgerEntry."Document Type")
                            {
                            }
                            column(VendLedgerEntry_VendLedgerEntry__Document_No__; VendLedgerEntry."Document No.")
                            {
                            }
                            column(VendLedgerEntry_VendLedgerEntry_Description; VendLedgerEntry.Description)
                            {
                            }
                            column(VendLedgerEntry_VendLedgerEntry__Currency_Code_; VendLedgerEntry."Currency Code")
                            {
                            }
                            column(VendDiscountPP; VendDiscountPP)
                            {
                            }
                            column(VendLedgerEntry_Entry_No_; "Entry No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                vend_value += "Detailed Vendor Ledg. Entry".Amount;
                                CLEAR(VendDiscountPP);
                                IF VendLedgerEntry."Posting Date" < VendLedgerEntry."Pmt. Discount Date" THEN
                                    VendDiscountPP := VendLedgerEntry."Pmt. Disc. Rcd.(LCY)";
                            end;
                        }
                    }

                    trigger OnAfterGetRecord()
                    var
                        lRecVendor: Record 23;
                    begin
                        gtxtVendName := '';
                        lRecVendor.GET("Vendor No.");
                        gtxtVendName := lRecVendor.Name;
                    end;
                }
                dataitem(DataItem4920; 271)
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"),
                                   "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Bank Account No.", "Posting Date");
                    column(Bank_Account_Ledger_Entry__Posting_Date_; "Posting Date")
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Amount; Amount)
                    {
                    }
                    column(StrBank; StrBank)
                    {
                    }
                    column("Movimento_BancárioCaption"; Movimento_BancárioCaptionLbl)
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
                    {
                    }
                    column(Bank_Account_Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
                    {
                    }
                    column(BankCaption; BankCaptionLbl)
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Document_Type; "Document Type")
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Document_No_; "Document No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        StrBank := '';
                        IF BankAccount.GET("Bank Account Ledger Entry"."Bank Account No.") THEN BEGIN
                            StrBank := BankAccount."No.";
                            IF BankAccount.Name <> '' THEN BEGIN
                                IF StrBank <> '' THEN
                                    StrBank := StrBank + ' - ';
                                StrBank := StrBank + BankAccount.Name;
                            END;
                        END;
                    end;
                }
                dataitem(DataItem5444; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(applied_value; applied_value)
                    {
                    }
                    column(Applied_ValueCaption; Applied_ValueCaptionLbl)
                    {
                    }
                    column(Integer_Number; Number)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                var
                    lRecCustomerNo: Record 18;
                begin
                    cust_value := 0;
                    vend_value := 0;

                    gtxtCustName := '';
                    lRecCustomerNo.GET("Customer No.");
                    gtxtCustName := lRecCustomerNo.Name;
                end;
            }

            trigger OnAfterGetRecord()
            var
            begin
                // IF NOT gBoolAutomatic THEN BEGIN
                //  IF lCodeEntityNo <> Entity."No." THEN BEGIN
                //    CLEAR(lRecEntityAss);
                //    lRecEntityAss.SETRANGE("Entity VAT Registration No.","VAT Registration No.");
                //    lRecEntityAss.SETRANGE(Type,lRecEntityAss.Type::Customer);
                //    IF PAGE.RUNMODAL(PAGE::"Entity Association List",lRecEntityAss) = ACTION::LookupOK THEN
                //      "Customer No. EntityAss" := lRecEntityAss."Customer No.";
                //
                //    lCodeEntityNo := Entity."No.";
                //  END;
                // END;
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
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);
        FormatAddr.Company(company_address, CompanyInfo);
    end;

    var
        Entity: Record Entity;
        CompanyInfo: Record 79;
        BankAccount: Record 270;

        "Detailed Cust. Ledg. Entry": Record "Detailed Cust. Ledg. Entry";
        "Detailed Vendor Ledg. Entry": Record "Detailed Vendor Ledg. Entry";
        "Bank Account Ledger Entry": Record "Bank Account Ledger Entry";
        FormatAddr: Codeunit 365;
        cust_value: Decimal;
        vend_value: Decimal;
        applied_value: Decimal;
        CustDiscountPP: Decimal;
        VendDiscountPP: Decimal;
        company_address: array[8] of Text[50];
        StrBank: Text[80];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Entity_No_CaptionLbl: Label 'Entity No.';
        Settlement_DetailCaptionLbl: Label 'Settlement Detail';
        Posting_DateCaptionLbl: Label 'Posting Date';
        Document_TypeCaptionLbl: Label 'Document Type';
        Document_No_CaptionLbl: Label 'Document No.';
        DescriptionCaptionLbl: Label 'Description';
        AmountCaptionLbl: Label 'Apllied Amount';
        Original_AmountCaptionLbl: Label 'Original Amount';
        Customer_Applied_DocumentsCaptionLbl: Label 'Customer Applied Documents';
        Payment_DiscountCaptionLbl: Label 'Payment Discount';
        AmountCaption_Control1000000031Lbl: Label 'Apllied Amount';
        Original_AmountCaption_Control1000000032Lbl: Label 'Original Amount';
        DescriptionCaption_Control1000000033Lbl: Label 'Description';
        Document_No_Caption_Control1000000035Lbl: Label 'Document No.';
        Posting_DateCaption_Control1000000036Lbl: Label 'Posting Date';
        Document_TypeCaption_Control1000000037Lbl: Label 'Document Type';
        Vendor_Applied_DocumentsCaptionLbl: Label 'Vendor Applied Documents';
        Payment_DiscountCaption_Control1000000030Lbl: Label 'Payment Discount';
        "Movimento_BancárioCaptionLbl": Label 'Bank Movement';
        BankCaptionLbl: Label 'Bank';
        Applied_ValueCaptionLbl: Label 'Applied Value';
        gtxtCustName: Text[50];
        gtxtVendName: Text[50];
        gBoolAutomatic: Boolean;



    procedure SetVariables(pBoolAutomatic: Boolean)
    begin
        gBoolAutomatic := pBoolAutomatic;
    end;
}

