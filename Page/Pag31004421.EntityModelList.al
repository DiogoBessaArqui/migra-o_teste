page 31004421 "Entity Model List"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Page </Comment>
    // //[*]</LMS>

    Caption = 'Entity Model List';
    CardPageID = "Entity Model";
    Description = 'ID:ENTITY.00.01.01.00';
    Editable = false;
    PageType = List;
    SourceTable = 31004377;

    layout
    {
        area(content)
        {
            repeater("Entity Model List")
            {
                field(Code; Code)
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

