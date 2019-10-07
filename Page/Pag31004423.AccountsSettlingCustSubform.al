page 31004423 "Accounts Settling Cust Subform"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Page </Comment>
    // //[*]</LMS>

    Caption = 'Accounts Settling Cust';
    DelayedInsert = true;
    Description = 'ID:ENTITY.00.01.01.00';
    PageType = ListPart;
    Permissions = TableData 21 = imd;
    RefreshOnActivate = true;
    SourceTable = 21;
    SourceTableView = WHERE("Open" = CONST(true));

    layout
    {
        area(content)
        {
            repeater("..")
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
                    Editable = false;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    Editable = false;
                }
                field("Remaining Amt. (LCY)"; "Remaining Amt. (LCY)")
                {
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
                field("Pmt. Disc. Given (LCY)"; "Pmt. Disc. Given (LCY)")
                {
                    Editable = false;
                    Visible = false;
                }
            }
            group("...")
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
                        field(gDecAmountToApply; gDecAmountToApply_)
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
                    lRecCustLedgerEntry: Record 21;
                begin
                    //<LMS Name="ana.fernandes" Date="01-03-2016" D="FinPack_ENT1.0" T="001"> -->
                    CurrPage.SETSELECTIONFILTER(lRecCustLedgerEntry);
                    IF lRecCustLedgerEntry.FINDSET() THEN
                        REPEAT
                            MarkEntry(lRecCustLedgerEntry);
                        UNTIL lRecCustLedgerEntry.NEXT() = 0;
                    //<LMS Name="ana.fernandes" Date="01-03-2016" D="FinPack_ENT1.0" T="001"> -->
                end;
            }
            action(CalcTotal)
            {
                Caption = 'CalcTotals';
                Visible = false;

                trigger OnAction()
                begin
                    CalcTotals();
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
        gDecSelectedBalance_: Decimal;
        gDecBalance_: Decimal;
        gDecAmountToApply_: Decimal;
        gDecPmtDiscount_: Decimal;

    procedure MarkEntry(var pRecCustLedgEntry: Record 21)
    begin
        // Mark Entry
        WITH pRecCustLedgEntry DO BEGIN
            IF "Applies-to ID" = '' THEN BEGIN
                "Applies-to ID" := USERID();
                CALCFIELDS("Remaining Amount");
                "Amount to Apply" := "Remaining Amount";
            END ELSE BEGIN
                "Applies-to ID" := '';
                "Amount to Apply" := 0;
            END;
            AccountsSettling.UpdateTotals();
            MODIFY();
            //COMMIT;
        END;
        CalcTotals();
    end;

    procedure CalcTotals()
    var
        lRecCustLedgEntry: Record 21;
        lDecPmtDiscount: Decimal;
    begin
        // Calc Totals

        gDecSelectedBalance_ := 0;
        gDecBalance_ := 0;
        gDecAmountToApply_ := 0;
        gDecPmtDiscount_ := 0;

        lRecCustLedgEntry.COPYFILTERS(Rec);
        IF lRecCustLedgEntry.FINDSET() THEN
            REPEAT
                lRecCustLedgEntry.CALCFIELDS("Remaining Amount");
                gDecBalance_ += lRecCustLedgEntry."Remaining Amount";
                IF lRecCustLedgEntry."Applies-to ID" = UPPERCASE(USERID()) THEN BEGIN
                    gDecSelectedBalance_ += lRecCustLedgEntry."Remaining Amount";
                    IF (lRecCustLedgEntry."Pmt. Discount Date" >= WORKDATE()) AND
                       (lRecCustLedgEntry."Remaining Amount" = lRecCustLedgEntry."Amount to Apply")
                    THEN
                        lDecPmtDiscount := lRecCustLedgEntry."Remaining Pmt. Disc. Possible";

                    gDecPmtDiscount_ += lDecPmtDiscount;
                    gDecAmountToApply_ += lRecCustLedgEntry."Amount to Apply" - lDecPmtDiscount;
                END;
            UNTIL lRecCustLedgEntry.NEXT() = 0;
    end;

    procedure GetAmounts(var p_balance_dec: Decimal; var p_selected_balance_dec: Decimal; var p_amount_apply_dec: Decimal)
    begin
        // Get Amounts

        p_balance_dec := gDecBalance_;
        p_selected_balance_dec := gDecSelectedBalance_;
        p_amount_apply_dec := gDecAmountToApply_;
    end;

    procedure GetRecCopy(var RecCopy: Record 21)
    begin
        RecCopy.COPYFILTERS(Rec);
    end;

    procedure GetRecFilters(): Text[1024]
    begin
        EXIT(GETVIEW());
    end;

    procedure ClearAppliesID()
    var
        lRecCustLedgEntry: Record 21;
    begin
        // Clear Applies ID

        CLEAR(lRecCustLedgEntry);
        lRecCustLedgEntry.COPYFILTERS(Rec);
        IF NOT lRecCustLedgEntry.ISEMPTY() THEN BEGIN
            lRecCustLedgEntry.MODIFYALL("Applies-to ID", '');
            lRecCustLedgEntry.MODIFYALL("Amount to Apply", 0);
        END;
    end;
}

