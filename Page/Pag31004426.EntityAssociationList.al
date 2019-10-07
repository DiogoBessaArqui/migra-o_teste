page 31004426 "Entity Association List"
{
    // version FinPack_ENT1.0

    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Page </Comment>
    // //[*]</LMS>

    Caption = 'Entity Association List';
    DelayedInsert = true;
    PageType = List;
    SourceTable = 31004378;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field(Name; Name)
                {
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                }
                field("Customer Balance (LCY)"; "Customer Balance (LCY)")
                {
                }
                field("Vendor Balance (LCY)"; "Vendor Balance (LCY)")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Entity VAT Registration No." := GETFILTER("Entity VAT Registration No.");
    end;
}

