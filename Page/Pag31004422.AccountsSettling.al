page 31004422 "Accounts Settling"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Page </Comment>
    // //[*]</LMS>

    Caption = 'Accounts Settling';
    DeleteAllowed = false;
    Description = 'ID:ENTITY.00.01.01.00';
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Worksheet;
    RefreshOnActivate = true;
    SourceTable = 31004376;

    layout
    {
        area(content)
        {
            group("Accounts Settling")
            {
                field("No."; "No.")
                {
                    Caption = 'Entity';
                    Editable = false;
                }
                field(Name; Name)
                {
                    Editable = false;
                }
                field("Customer No."; "Customer No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Vendor No."; "Vendor No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Customer No. EntityAss"; "Customer No. EntityAss")
                {
                }
                field("Vendor No. EntityAss"; "Vendor No. EntityAss")
                {
                }
            }

            group("Customer Open Ledger Entries")
            {
                Caption = 'Customer Open Ledger Entries';
                Visible = false;
            }
            part(CustEntry; 31004423)
            {
                Caption = 'Customer Open Ledger Entries';
                SubPageLink = "Customer No." = field("Customer No. EntityAss");
            }
            group("Vendor Open Ledger Entries")
            {
                Caption = 'Vendor Open Ledger Entries';
                Visible = false;
            }
            part(VendEntry; 31004424)
            {
                Caption = 'Vendor Open Ledger Entries';
                SubPageLink = "Vendor No." = field("Vendor No. EntityAss");
            }

            group("...")
            {
                fixed("..")
                {
                    group(Balance)
                    {
                        Caption = 'Balance';
                        field(gDecBalance; gDecBalance_)
                        {
                            Caption = 'Totals';
                            Editable = false;
                        }
                    }
                    group("Amount to Apply")
                    {
                        Caption = 'Amount to Apply';
                        Visible = false;
                        field(gDecDiference; gDecDiference_)
                        {
                            Caption = 'Amount to Apply';
                            Editable = false;
                            Visible = false;
                        }
                    }
                    group(Difference)
                    {
                        Caption = 'Difference';
                        field(gDecAmountToApply; gDecAmountToApply_)
                        {
                            Caption = 'Difference';
                            Editable = false;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Register)
            {
                Caption = 'Register';
                action("Post Directly With Diference")
                {
                    Caption = 'Post Directly With Diference';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // Post Directly With Diference
                        PostDirectlyWithDiference();
                    end;
                }
                action("Post Preview With Diference")
                {
                    Caption = 'Post Preview With Diference';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        // Post Preview With Difference
                        PostPreviewWithDiference();
                    end;
                }
                action("Post Directly Without Diference")
                {
                    Caption = 'Post Directly Without Diference';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // Post Directly Without Diference
                        PostDirectlyWithoutDiference();
                    end;
                }
                action("Post Preview Without Diference")
                {
                    Caption = 'Post Preview Without Diference';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    begin
                        // Post Preview Without Diference
                        PostPreviewWithoutDiference();
                    end;
                }
            }
            action(Refresh)
            {
                Caption = 'Refresh';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+A';

                trigger OnAction()
                begin
                    UpdateTotals();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    var
        gDecBalance_: Decimal;
        gDecSelectedBalance: Decimal;
        gDecAmountToApply_: Decimal;
        gDecDiference_: Decimal;

    procedure UpdateTotals()
    var
        lDecVendorBalance: Decimal;
        lDecVendSelectedBalance: Decimal;
        lDecCustAmountToApply: Decimal;
        lDecVendAmountToApply: Decimal;
    begin
        // Update Totals
        gDecBalance_ := 0;
        gDecSelectedBalance := 0;
        gDecAmountToApply_ := 0;

        CurrPage.CustEntry.PAGE.CalcTotals();
        CurrPage.VendEntry.PAGE.CalcTotals();
        CurrPage.CustEntry.PAGE.GetAmounts(gDecBalance_, gDecSelectedBalance, lDecCustAmountToApply);
        CurrPage.VendEntry.PAGE.GetAmounts(lDecVendorBalance, lDecVendSelectedBalance, lDecVendAmountToApply);

        gDecBalance_ += lDecVendorBalance;
        gDecSelectedBalance += lDecVendSelectedBalance;
        gDecAmountToApply_ := lDecCustAmountToApply + lDecVendAmountToApply;
        IF lDecCustAmountToApply > lDecVendAmountToApply THEN
            gDecDiference_ := lDecVendAmountToApply
        ELSE
            gDecDiference_ := lDecCustAmountToApply;
        CurrPage.UPDATE();
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateTotals();
    end;

    procedure PostDirectlyWithDiference()
    var
        lCduEntityMgt: Codeunit 31004342;
    begin
        UpdateTotals();

        CLEAR(lCduEntityMgt);
        lCduEntityMgt.RegisterWithDiference(Rec, CurrPage.CustEntry.PAGE.GetRecFilters(), CurrPage.VendEntry.PAGE.GetRecFilters(), TRUE);

        UpdateTotals();
    end;

    procedure PostPreviewWithDiference()
    var
        lCduEntityMgt: Codeunit 31004342;
    begin
        UpdateTotals();

        CLEAR(lCduEntityMgt);
        lCduEntityMgt.RegisterWithDiference(Rec, CurrPage.CustEntry.PAGE.GetRecFilters(), CurrPage.VendEntry.PAGE.GetRecFilters(), FALSE);

        UpdateTotals();
    end;

    procedure PostDirectlyWithoutDiference()
    var
        lCduEntityMgt: Codeunit 31004342;
    begin
        UpdateTotals();

        CLEAR(lCduEntityMgt);
        lCduEntityMgt.RegisterWithoutDiference(Rec, CurrPage.CustEntry.PAGE.GetRecFilters(), CurrPage.VendEntry.PAGE.GetRecFilters(), TRUE);

        UpdateTotals();
    end;

    procedure PostPreviewWithoutDiference()
    var
        lCduEntityMgt: Codeunit 31004342;
    begin
        UpdateTotals();

        CLEAR(lCduEntityMgt);
        lCduEntityMgt.RegisterWithoutDiference(Rec, CurrPage.CustEntry.PAGE.GetRecFilters(), CurrPage.VendEntry.PAGE.GetRecFilters(), FALSE);

        UpdateTotals();
    end;
}

