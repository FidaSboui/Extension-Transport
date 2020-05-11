page 84002 "TRANSP Shipment Slip Subform"
{
    Caption = 'Line';
    PageType = ListPart;
    SourceTable = "TRANSP Shipment Slip Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Shipment Slip No."; "Shipment Slip No.")
                {
                    ApplicationArea = all;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = all;
                }
                field("Order No."; "Order No.")
                {
                    ApplicationArea = all;
                }
                field("Shipment No."; "Shipment No.")
                {
                    ApplicationArea = all;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Name 2"; "Ship-to Name 2")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                    ApplicationArea = all;
                }
                field("Ship-to City"; "Ship-to City")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = all;
                }
                field("Gross Weight"; "Gross Weight")
                {
                    ApplicationArea = all;
                }
                field("Net Weight"; "Net Weight")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    ApplicationArea = all;
                }
                field("Ship-to County"; "Ship-to County")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Country/Region Code"; "Ship-to Country/Region Code")
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
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

