page 31004420 "Entity Model"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Page </Comment>
    // //[*]</LMS>

    Caption = 'Entity Model';
    Description = 'ID:ENTITY.00.01.01.00';
    PageType = Card;
    SourceTable = 31004377;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Code)
                {
                }
                field(Type; Type)
                {
                }
                field(Description; Description)
                {
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                }
                field("Vendor Posting Group"; "Vendor Posting Group")
                {
                }
            }
        }
    }

    actions
    {
    }
}

