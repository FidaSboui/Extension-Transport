pageextension 84010 "TRANSP RoleCenterExt" extends "Order Processor Role Center"
{

    actions
    {
        addlast(Sections)
        {
            group("Transport")
            {
                Caption = 'shipment';
                action("Shipment Slip List")
                {
                    Caption = 'Shipment Slip List';
                    RunObject = page "TRANSP Shipment Slip List";
                    ApplicationArea = All;
                }
            }

        }

    }


}