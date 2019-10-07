page 31004417 "Entity Setup"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Page </Comment>
    // //[*]</LMS>

    Caption = 'Entity Setup';
    DataCaptionExpression = '';
    Description = 'ID:ENTITY.00.01.01.00';
    PageType = Card;
    SourceTable = 31004375;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Entity Series Nos."; "Entity Series Nos.")
                {
                }
                group(Entity)
                {
                    field("Entity Journal Template"; "Entity Journal Template")
                    {
                    }
                    field("Entity Journal Batch"; "Entity Journal Batch")
                    {
                    }
                }
            }
        }
    }

    actions
    {
    }
}

