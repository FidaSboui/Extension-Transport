pageextension 84001 "TRANSP PageExt-PostedSalesShip" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Shipping Time")
        {
            field("Shipment Slip No."; "Shipment Slip No.")
            {
                ApplicationArea = all;
            }
            field("Pallets Number"; "Pallets Number")
            {
                ApplicationArea = all;
            }
            field("Packages Number"; "Packages Number")
            {
                ApplicationArea = all;
            }
            field("Shpt. Slip Gross Weight"; "Shpt. Slip Gross Weight")
            {
                ApplicationArea = all;
            }
            field("Shpt. Slip Net Weight"; "Shpt. Slip Net Weight")
            {
                ApplicationArea = all;
            }
            field("Net Weight"; "Net Weight")
            {
                ApplicationArea = all;
            }
        }
    }
}

