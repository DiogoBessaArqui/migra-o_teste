page 31004418 "Entity Card"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Page </Comment>
    // //[*]</LMS>

    Caption = 'Entity Card';
    Description = 'ID:ENTITY.00.01.01.00';
    PageType = Card;
    SourceTable = 31004376;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field(Name; Name)
                {
                }
                field("Name 2"; "Name 2")
                {
                }
                field(Address; Address)
                {
                }
                field("Address 2"; "Address 2")
                {
                }
                field("Postal Code"; "Postal Code")
                {
                }
                field(City; City)
                {
                }
                field(County; County)
                {
                }
                field("Country Code"; "Country Code")
                {
                }
                field("Customer No."; "Customer No.")
                {
                    Visible = false;
                }
                field("Vendor No."; "Vendor No.")
                {
                    Visible = false;
                }
                field("Customer Balance (LCY)"; "Customer Balance (LCY)")
                {
                    Editable = false;
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        DtldCustLedgEntry: Record 379;
                    begin
                        DtldCustLedgEntry.SETRANGE("Customer No.", "Customer No.");
                        DtldCustLedgEntry.SETRANGE("Posting Date", "Date Filter");

                        CustDrillDownOnEntries(DtldCustLedgEntry);
                    end;
                }
                field("Vendor Balance (LCY)"; "Vendor Balance (LCY)")
                {
                    Editable = false;
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        DtldVendLedgEntry: Record 380;
                    begin
                        DtldVendLedgEntry.SETRANGE("Vendor No.", "Vendor No.");
                        DtldVendLedgEntry.SETRANGE("Posting Date", "Date Filter");

                        VendorDrillDownOnEntries(DtldVendLedgEntry);
                    end;
                }
                field("Balance (LCY)"; "Balance (LCY)")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Entity Customer Balance (LCY)"; "Entity Customer Balance (LCY)")
                {
                    Caption = 'Customer Balance (LCY) ';
                }
                field("Entity Vendor Balance (LCY)"; "Entity Vendor Balance (LCY)")
                {
                    Caption = 'Vendor Balance (LCY)';
                }
                field("Entity Balance (LCY)"; "Entity Balance (LCY)")
                {
                    Caption = 'Balance (LCY)';
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                }
                field("Customer Model"; "Customer Model")
                {
                }
                field("Vendor Model"; "Vendor Model")
                {
                }
            }
            group("Bank Account")
            {
                Caption = 'Bank Account';
                field("Bank Account Code"; "Bank Account Code")
                {
                }
                field("Bank Name"; "Bank Name")
                {
                }
                field("Bank Address"; "Bank Address")
                {
                }
                field("Bank Post Code"; "Bank Post Code")
                {
                }
                field("Bank City"; "Bank City")
                {
                }
                field("Bank Country/Region Code"; "Bank Country/Region Code")
                {
                }
                field("Phone No."; "Phone No.")
                {
                }
                field("Fax No."; "Fax No.")
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("Home Page"; "Home Page")
                {
                }
                field("Bank Account No."; "Bank Account No.")
                {
                }
                field(IBAN; IBAN)
                {
                }
                field("CCC Bank Account No."; "CCC Bank Account No.")
                {
                }
                field("CCC Bank Branch No."; "CCC Bank Branch No.")
                {
                }
                field("CCC Bank No."; "CCC Bank No.")
                {
                }
                field("CCC No."; "CCC No.")
                {
                }
                field("SWIFT Code"; "SWIFT Code")
                {
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field("Payment Terms Code"; "Payment Terms Code")
                {
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; "Currency Code")
                {
                }
                field("Language Code"; "Language Code")
                {
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Cards)
            {
                Caption = 'Cards';
                group(Create)
                {
                    Caption = 'Create';
                    action(Customer)
                    {
                        Caption = 'Customer';

                        trigger OnAction()
                        var
                            EntityMgt: Codeunit 31004342;
                        begin
                            EntityMgt.CreateCustomer(Rec, TRUE);
                        end;
                    }
                    action(Vendor)
                    {
                        Caption = 'Vendor';

                        trigger OnAction()
                        var
                            EntityMgt: Codeunit 31004342;
                        begin
                            EntityMgt.CreateVendor(Rec, TRUE);
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Accounts Settling")
                {
                    Caption = 'Accounts Settling';
                    Description = 'ApplyEntries';
                    Image = GLRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 31004422;
                    RunPageLink = "No." = field("No.");
                }
                action("&Entity Association")
                {
                    Caption = 'Entity Association';
                    Image = ViewPage;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        lRecEntityAssociation: Record 31004378;
                    begin
                        CLEAR(lRecEntityAssociation);
                        lRecEntityAssociation.SETRANGE("Entity VAT Registration No.", "VAT Registration No.");
                        PAGE.RUNMODAL(PAGE::"Entity Association List", lRecEntityAssociation);
                        CalcBalance();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    var
        CustComment: Boolean;
        VendComment: Boolean;


    procedure CheckComments()
    var
        Customer_: Record 18;
        Vendor_: Record 23;
    begin
        // Check Vendor and Customer for Comments
        IF Customer_.GET("Customer No.") THEN BEGIN
            Customer_.CALCFIELDS(Comment);
            CustComment := Customer_.Comment;
        END;
        IF Vendor_.GET("Vendor No.") THEN BEGIN
            Vendor_.CALCFIELDS(Comment);
            VendComment := Vendor_.Comment;
        END;
    end;

    procedure CustDrillDownOnEntries(var DtldCustLedgEntry: Record 379)
    var
        CustLedgEntry: Record 21;
    begin
        CustLedgEntry.RESET();
        DtldCustLedgEntry.COPYFILTER("Customer No.", CustLedgEntry."Customer No.");
        DtldCustLedgEntry.COPYFILTER("Currency Code", CustLedgEntry."Currency Code");
        DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 1", CustLedgEntry."Global Dimension 1 Code");
        DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 2", CustLedgEntry."Global Dimension 2 Code");
        CustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
        PAGE.RUN(0, CustLedgEntry);
    end;

    procedure VendorDrillDownOnEntries(var DtldVendLedgEntry: Record 380)
    var
        VendLedgEntry: Record 25;
    begin
        VendLedgEntry.RESET();
        DtldVendLedgEntry.COPYFILTER("Vendor No.", VendLedgEntry."Vendor No.");
        DtldVendLedgEntry.COPYFILTER("Currency Code", VendLedgEntry."Currency Code");
        DtldVendLedgEntry.COPYFILTER("Initial Entry Global Dim. 1", VendLedgEntry."Global Dimension 1 Code");
        DtldVendLedgEntry.COPYFILTER("Initial Entry Global Dim. 2", VendLedgEntry."Global Dimension 2 Code");
        VendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date");
        PAGE.RUN(0, VendLedgEntry);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CheckComments();
        CalcBalance();
    end;
}

