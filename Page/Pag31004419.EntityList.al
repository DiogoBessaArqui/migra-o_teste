page 31004419 "Entity List"
{
    // version FinPack_ENT1.0

    // [ID:ENTITY.00.01.01.00]
    // 
    // //[*]<LMS Name="ana.fernandes" Date="26-02-2016" D="FinPack_ENT1.0" T="001">
    // //[*] <Comment> ADD_ON: Entity </Comment>
    // //[*] <Comment> New Page </Comment>
    // //[*]</LMS>

    Caption = 'Entity List';
    CardPageID = "Entity Card";
    Description = 'ID:ENTITY.00.01.01.00';
    PageType = List;
    SourceTable = 31004376;

    layout
    {
        area(content)
        {
            repeater(".")
            {
                field("No."; "No.")
                {
                }
                field(Name; Name)
                {
                }
                field(Address; Address)
                {
                }
                field("Postal Code"; "Postal Code")
                {
                }
                field(City; City)
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
            group("<Action1000000049>")
            {
                Caption = 'Cards';
                group("<Action1000000052>")
                {
                    Caption = 'Create';
                    action("<Action1000000053>")
                    {
                        Caption = 'Customer';

                        trigger OnAction()
                        var
                            EntityMgt: Codeunit 31004342;
                        begin
                            EntityMgt.CreateCustomer(Rec, TRUE);
                        end;
                    }
                    action("<Action1000000054>")
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
            group("<Action1000000050>")
            {
                Caption = 'F&unctions';
                action("<Action1000000014>")
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
                    RunObject = Page 31004426;
                    RunPageLink = "VAT Registration No." = field("VAT Registration No.");


                }
            }
        }
    }
}

