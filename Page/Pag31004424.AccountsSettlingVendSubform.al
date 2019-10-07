page 31004424 "Accounts Settling Vend Subform"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Page </Comment>
    // //[*]</LMS>

    Caption = 'Accounts Settling Vend';
    DelayedInsert = true;
    Description = 'ID:ENTITY.00.01.01.00';
    PageType = ListPart;
    Permissions = TableData 25 = imd;
    RefreshOnActivate = true;
    SourceTable = 25;
    SourceTableView = WHERE(Open = CONST(true));

    layout
    {
        area(content)
        {
            repeater("...")
            {
                field("Applies-to ID"; "Applies-to ID")
                {
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        MarkEntry(Rec);
                        CurrPage.UPDATE();
                    end;
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;
                }
                field("Document Type"; "Document Type")
                {
                    Editable = false;
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    Editable = false;
                }
                field(Amount; Amount)
                {
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    Editable = false;
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    Editable = false;
                }
                field("Amount to Apply"; "Amount to Apply")
                {
                }
                field("Due Date"; "Due Date")
                {
                    Editable = false;
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                }
                field("Original Pmt. Disc. Possible"; "Original Pmt. Disc. Possible")
                {
                }
                field("Remaining Pmt. Disc. Possible"; "Remaining Pmt. Disc. Possible")
                {
                }
                field("Pmt. Disc. Rcd.(LCY)"; "Pmt. Disc. Rcd.(LCY)")
                {
                    Editable = false;
                    Visible = false;
                }
            }
            group("..")
            {
                fixed(".")
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
                    group("Selected Balance")
                    {
                        Caption = 'Selected Balance';
                        field(gDecSelectedBalance; gDecSelectedBalance_)
                        {
                            Caption = 'Selected Balance';
                            Editable = false;
                        }
                    }
                    group("Pmt. Discount")
                    {
                        Caption = 'Pmt. Discount';
                        field(gDecPmtDiscount; gDecPmtDiscount_)
                        {
                        }
                    }
                    group("Amount to Apply.")
                    {
                        Caption = 'Amount to Apply';
                        field(gDecAmountApplied; gDecAmountApplied_)
                        {
                            Caption = 'Amount to Apply';
                            Editable = false;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Applies-to ID")
            {
                Caption = 'Set Applies-to ID';
                Image = SelectLineToApply;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    lRecVendLedgerEntry: Record 25;
                begin
                    //<LMS Name="ana.fernandes" Date="01-03-2016" D="FinPack_ENT1.0" T="001"> -->
                    CurrPage.SETSELECTIONFILTER(lRecVendLedgerEntry);
                    IF lRecVendLedgerEntry.FINDSET() THEN
                        REPEAT
                            MarkEntry(lRecVendLedgerEntry);
                        UNTIL lRecVendLedgerEntry.NEXT() = 0;
                    //<LMS Name="ana.fernandes" Date="01-03-2016" D="FinPack_ENT1.0" T="001"> -->
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalcTotals();
    end;

    trigger OnClosePage()
    begin
        ClearAppliesID();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CalcTotals();
    end;

    var
        AccountsSettling: Page 31004422;
        gDecBalance_: Decimal;
        gDecSelectedBalance_: Decimal;
        gDecAmountApplied_: Decimal;
        gDecPmtDiscount_: Decimal;

    procedure MarkEntry(var pRecVendLedgerEntry: Record 25)
    begin
        // Mark Entries
        WITH pRecVendLedgerEntry DO BEGIN
            IF "Applies-to ID" = '' THEN BEGIN
                CALCFIELDS("Remaining Amount");
                "Applies-to ID" := USERID();
                "Amount to Apply" := "Remaining Amount";
            END ELSE BEGIN
                "Applies-to ID" := '';
                "Amount to Apply" := 0;
            END;
            MODIFY();
        END;
        CalcTotals();
        AccountsSettling.UpdateTotals();
    end;

    procedure CalcTotals()
    var
        lRecVendLedgEntry: Record 25;
        lDecPmtDiscount: Decimal;
    begin
        // Calc Totals

        gDecBalance_ := 0;
        gDecSelectedBalance_ := 0;
        gDecAmountApplied_ := 0;
        gDecPmtDiscount_ := 0;

        CLEAR(lRecVendLedgEntry);
        lRecVendLedgEntry.COPYFILTERS(Rec);
        IF lRecVendLedgEntry.FINDSET() THEN
            REPEAT
                lRecVendLedgEntry.CALCFIELDS("Remaining Amount");
                gDecBalance_ += lRecVendLedgEntry."Remaining Amount";
                IF lRecVendLedgEntry."Applies-to ID" = UPPERCASE(USERID()) THEN BEGIN
                    gDecSelectedBalance_ += lRecVendLedgEntry."Remaining Amount";
                    IF (lRecVendLedgEntry."Pmt. Discount Date" >= WORKDATE()) AND
                       (lRecVendLedgEntry."Remaining Amount" = lRecVendLedgEntry."Amount to Apply")
                    THEN
                        lDecPmtDiscount := lRecVendLedgEntry."Remaining Pmt. Disc. Possible";

                    gDecPmtDiscount_ += lDecPmtDiscount;
                    gDecAmountApplied_ += lRecVendLedgEntry."Amount to Apply" - lDecPmtDiscount;
                END;
            UNTIL lRecVendLedgEntry.NEXT() = 0;
    end;

    procedure GetAmounts(var p_balance_dec: Decimal; var p_selected_balance_dec: Decimal; var p_amount_apply_dec: Decimal)
    begin
        // Get Amounts

        p_balance_dec := gDecBalance_;
        p_selected_balance_dec := gDecSelectedBalance_;
        p_amount_apply_dec := gDecAmountApplied_;
    end;

    procedure GetRecCopy(var RecCopy: Record 25)
    begin
        RecCopy.COPYFILTERS(Rec);
    end;

    procedure GetRecFilters(): Text[1024]
    begin
        EXIT(GETVIEW());
    end;

    procedure ClearAppliesID()
    var
        lRecVendLedgEntry: Record 25;
    begin
        // Clear Applies ID

        CLEAR(lRecVendLedgEntry);
        lRecVendLedgEntry.COPYFILTERS(Rec);
        IF NOT lRecVendLedgEntry.ISEMPTY() THEN BEGIN
            lRecVendLedgEntry.MODIFYALL("Applies-to ID", '');
            lRecVendLedgEntry.MODIFYALL("Amount to Apply", 0);
        END;
    end;
}

