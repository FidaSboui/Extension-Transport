page 84000 "TRANSP Shipment Slip List"
{
    Caption = 'Shipment Slip List';
    CardPageID = "TRANSP Shipment Slip Card";
    Editable = false;
    PageType = List;
    SourceTable = "TRANSP Shipment Slip Header";
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field("Departure Time"; "Departure Time")
                {
                    ApplicationArea = all;
                }
            }
            field("End of order Time"; "End of order Time")
            {
                ApplicationArea = all;
            }
            field("Posting date"; "Posting date")
            {
                ApplicationArea = all;
            }
            field("No. Series"; "No. Series")
            {
                ApplicationArea = all;
            }
            field(Status; Status)
            {
                ApplicationArea = all;
            }
            field("Created Date-Time"; "Created Date-Time")
            {
                ApplicationArea = all;
            }
            field("Created By UserID"; "Created By UserID")
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
            field("Shipping Agent Code"; "Shipping Agent Code")
            {
                ApplicationArea = all;
            }
            field("Package Tracking No."; "Package Tracking No.")
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

