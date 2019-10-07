page 31004425 "Entity General Journal"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Page </Comment>
    // //[*]</LMS>

    AutoSplitKey = true;
    Caption = 'Entity General Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    Description = 'ID:ENTITY.00.01.01.00';
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = 81;

    layout
    {
        area(content)
        {
            repeater("Entity General Journal")
            {
                field("Posting Date"; "Posting Date")
                {
                }
                field("Transaction No."; "Transaction No.")
                {
                }
                field("Document Date"; "Document Date")
                {
                    Visible = false;
                }
                field("Document Type"; "Document Type")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Bill No."; "Bill No.")
                {
                }
                field("External Document No."; "External Document No.")
                {
                    Visible = false;
                }
                field("Account Type"; "Account Type")
                {

                    trigger OnValidate()
                    var
                        GenJnlManagement: codeunit 230;
                        AccName_: Text[100];
                        BalAccName_: Text[50];
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName_, BalAccName_);
                    end;
                }
                field("Account No."; "Account No.")
                {

                    trigger OnValidate()
                    var
                        GenJnlManagement: codeunit 230;
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName_, BalAccName_);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field(Description; Description)
                {
                }
                field("Acc: cash-flow code"; "Acc: cash-flow code")
                {
                    Caption = 'Acc: cash-flow code';
                }
                field("DRF Code"; "DRF Code")
                {
                }
                field("Business Unit Code"; "Business Unit Code")
                {
                    Visible = false;
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    Visible = false;
                }
                field("Campaign No."; "Campaign No.")
                {
                    Visible = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    AssistEdit = true;
                    Visible = false;

                    trigger OnAssistEdit()
                    var
                        ChangeExchangeRate: Page "Change Exchange Rate";
                    begin
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date");
                        IF ChangeExchangeRate.RUNMODAL() = ACTION::OK THEN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());

                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Gen. Posting Type"; "Gen. Posting Type")
                {
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    Visible = false;
                }
                field("UE Aquisition Not Accep."; "UE Aquisition Not Accep.")
                {
                }
                field("Not in VAT Report"; "Not in VAT Report")
                {
                }
                field("Debit Amount"; "Debit Amount")
                {
                }
                field("Credit Amount"; "Credit Amount")
                {
                }
                field(Amount; Amount)
                {
                    Visible = false;
                }
                field("VAT Amount"; "VAT Amount")
                {
                    Visible = false;
                }
                field("VAT Difference"; "VAT Difference")
                {
                    Visible = false;
                }
                field("Bal. VAT Amount"; "Bal. VAT Amount")
                {
                    Visible = false;
                }
                field("Bal. VAT Difference"; "Bal. VAT Difference")
                {
                    Visible = false;
                }
                field("Bal. Account Type"; "Bal. Account Type")
                {
                }
                field("Bal. Account No."; "Bal. Account No.")
                {

                    trigger OnValidate()
                    var
                        GenJnlManagement: Codeunit GenJnlManagement;

                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName_, BalAccName_);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Bal: cash-flow code"; "Bal: cash-flow code")
                {
                    Caption = 'Bal: cash-flow code';
                }
                field("Bal. DRF Code"; "Bal. DRF Code")
                {
                }
                field("Bal. Gen. Posting Type"; "Bal. Gen. Posting Type")
                {
                }
                field("Bal. Gen. Bus. Posting Group"; "Bal. Gen. Bus. Posting Group")
                {
                }
                field("Bal. Gen. Prod. Posting Group"; "Bal. Gen. Prod. Posting Group")
                {
                }
                field("Bal. VAT Bus. Posting Group"; "Bal. VAT Bus. Posting Group")
                {
                    Visible = false;
                }
                field("Bal. VAT Prod. Posting Group"; "Bal. VAT Prod. Posting Group")
                {
                    Visible = false;
                }
                field("Bill-to/Pay-to No."; "Bill-to/Pay-to No.")
                {
                    Visible = false;
                }
                field("Ship-to/Order Address Code"; "Ship-to/Order Address Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field(ShortcutDimCode_3; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode_4; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode_5; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode_6; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode_7; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode_8; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    Visible = false;
                }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                {
                    Visible = false;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    Visible = false;
                }
                field("Applies-to Bill No."; "Applies-to Bill No.")
                {
                }
                field("Applies-to ID"; "Applies-to ID")
                {
                    Visible = false;
                }
                field("On Hold"; "On Hold")
                {
                    Visible = false;
                }
                field("Bank Payment Type"; "Bank Payment Type")
                {
                    Visible = false;
                }
                field("Reason Code"; "Reason Code")
                {
                    Visible = false;
                }
            }
            group(".")
            {
                field(AccName; AccName_)
                {
                    Caption = 'Account Name';
                    Editable = false;
                }
                field(BalAccName; BalAccName_)
                {
                    Caption = 'Bal. Account Name';
                    Editable = false;
                }
                field(Balance; Balance_ + "Balance (LCY)" - xRec."Balance (LCY)")
                {
                    AutoFormatType = 1;
                    Caption = 'Balance';
                    Editable = false;
                    Visible = BalanceVisible;
                }
                field(TotalBalance; TotalBalance_ + "Balance (LCY)" - xRec."Balance (LCY)")
                {
                    AutoFormatType = 1;
                    Caption = 'Total Balance';
                    Editable = false;
                    Visible = TotalBalanceVisible;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions();
                    end;
                }
            }
            group("A&ccount")
            {
                Caption = 'A&ccount';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Codeunit 15;
                    ShortCutKey = 'Shift+F7';
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    RunObject = Codeunit 14;
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Apply Entries")
                {
                    Caption = 'Apply Entries';
                    Ellipsis = true;
                    Image = ApplyEntries;
                    RunObject = Codeunit 225;
                    ShortCutKey = 'Shift+F11';
                }
                action("Insert Conv. LCY Rndg. Lines")
                {
                    Caption = 'Insert Conv. LCY Rndg. Lines';
                    RunObject = Codeunit 407;
                }
                separator("-")
                {
                    Caption = '-';
                }
                action("&Get Standard Journals")
                {
                    Caption = '&Get Standard Journals';
                    Ellipsis = true;
                    Image = GetStandardJournal;

                    trigger OnAction()
                    var
                        StdGenJnl: Record 750;
                    begin
                        StdGenJnl.FILTERGROUP := 2;
                        StdGenJnl.SETRANGE("Journal Template Name", "Journal Template Name");
                        StdGenJnl.FILTERGROUP := 0;

                        IF PAGE.RUNMODAL(PAGE::"Standard General Journals", StdGenJnl) = ACTION::LookupOK THEN BEGIN
                            StdGenJnl.CreateGenJnlFromStdJnl(StdGenJnl, CurrentJnlBatchName);
                            MESSAGE(Text000Lbl, StdGenJnl.Code);
                        END;

                        CurrPage.UPDATE(TRUE);
                    end;
                }
                action("&Save as Standard Journal")
                {
                    Caption = '&Save as Standard Journal';
                    Ellipsis = true;
                    Image = SaveasStandardJournal;

                    trigger OnAction()
                    var
                        GenJnlBatch: Record 232;
                        GeneralJnlLines: Record 81;
                        StdGenJnl: Record 750;
                        SaveAsStdGenJnl: Report 750;
                    begin
                        GeneralJnlLines.SETFILTER("Journal Template Name", "Journal Template Name");
                        GeneralJnlLines.SETFILTER("Journal Batch Name", CurrentJnlBatchName);
                        CurrPage.SETSELECTIONFILTER(GeneralJnlLines);
                        GeneralJnlLines.COPYFILTERS(Rec);

                        GenJnlBatch.GET("Journal Template Name", CurrentJnlBatchName);
                        SaveAsStdGenJnl.Initialise(GeneralJnlLines, GenJnlBatch);
                        SaveAsStdGenJnl.RUNMODAL();
                        IF NOT SaveAsStdGenJnl.GetStdGeneralJournal(StdGenJnl) THEN
                            EXIT;

                        MESSAGE(Text001Lbl, StdGenJnl.Code);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action(Reconcile)
                {
                    Caption = 'Reconcile';
                    Image = Reconcile;
                    ShortCutKey = 'Ctrl+F11';

                    trigger OnAction()
                    begin
                        GLReconcile.SetGenJnlLine(Rec);
                        GLReconcile.RUN();
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintGenJnlLine(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        lCduGenJnlPost: Codeunit "Gen. Jnl.-Post";
                    begin
                        //lCduGenJnlPost.Preview(TRUE);
                        lCduGenJnlPost.CheckNoSeriesPaymentJournal(TRUE);
                        lCduGenJnlPost.RUN(Rec);

                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    var
                        lCduGenJnlPostPrint: Codeunit "Gen. Jnl.-Post+Print";
                    begin
                        lCduGenJnlPostPrint.CheckPrintPaymentJournal(TRUE);
                        lCduGenJnlPostPrint.RUN(Rec);

                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
        OnAfterGetCurrRecord();
    end;

    trigger OnInit()
    begin
        TotalBalanceVisible := TRUE;
        BalanceVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateBalance();
        SetUpNewLine(xRec, Balance_, BelowxRec);
        CLEAR(ShortcutDimCode);
        CLEAR(AccName_);
        OnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()

    begin
        CurrentJnlBatchName := "Journal Batch Name";
    end;

    var
        GenJnlManagement: Codeunit 230;
        ReportPrint: Codeunit 228;
        GLReconcile: Page 345;
        CurrentJnlBatchName: Code[10];
        AccName_: Text[100];
        BalAccName_: Text[50];
        Balance_: Decimal;
        TotalBalance_: Decimal;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        Text000Lbl: Label 'General Journal lines have been successfully inserted from Standard General Journal %1.';
        Text001Lbl: Label 'Standard General Journal %1 has been successfully created.';
        [InDataSet]
        BalanceVisible: Boolean;
        [InDataSet]
        TotalBalanceVisible: Boolean;

    local procedure UpdateBalance()
    begin
        GenJnlManagement.CalcBalance(Rec, xRec, Balance_, TotalBalance_, ShowBalance, ShowTotalBalance);
        BalanceVisible := ShowBalance;
        TotalBalanceVisible := ShowTotalBalance;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GenJnlManagement.GetAccounts(Rec, AccName_, BalAccName_);
        UpdateBalance();
    end;
}

