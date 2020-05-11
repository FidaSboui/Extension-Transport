page 84003 "TRANSPGet Sales Shipment Order"
{
    Caption = 'Sales Shipment To Assign';
    Editable = false;
    PageType = Card;
    Permissions = TableData "Sales Shipment Header" = r;
    SourceTable = "Sales Shipment Header";
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {

            field("No."; "No.")
            {
                ApplicationArea = all;
            }
            field("Sell-to Customer No."; "Sell-to Customer No.")
            {
                ApplicationArea = all;
            }
            field("Bill-to Name"; "Bill-to Name")
            {
                ApplicationArea = all;
            }
            field("Bill-to Name 2"; "Bill-to Name 2")
            {
                ApplicationArea = all;
            }
            field("Bill-to Address"; "Bill-to Address")
            {
                ApplicationArea = all;
            }
            field("Bill-to Address 2"; "Bill-to Address 2")
            {
                ApplicationArea = all;
            }
            field("Bill-to City"; "Bill-to City")
            {
                ApplicationArea = all;
            }
            field("Ship-to Code"; "Ship-to Code")
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
            field("Ship-to Contact"; "Ship-to Contact")
            {
                ApplicationArea = all;
            }
            field("Order Date"; "Order Date")
            {
                ApplicationArea = all;
            }
            field("Posting Date"; "Posting Date")
            {
                ApplicationArea = all;
            }
            field("Location Code"; "Location Code")
            {
                ApplicationArea = all;
            }
            field("Salesperson Code"; "Salesperson Code")
            {
                ApplicationArea = all;
            }
            field(Comment; Comment)
            {
                ApplicationArea = all;
            }
            field(Amount; Amount)
            {
                ApplicationArea = all;
            }
            field("Amount Including VAT"; "Amount Including VAT")
            {
                ApplicationArea = all;
            }
            field("Sell-to Customer Name"; "Sell-to Customer Name")
            {
                ApplicationArea = all;

            }
            field("Document Date"; "Document Date")
            {
                ApplicationArea = all;
            }
            field("External Document No."; "External Document No.")
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
            field("Requested Delivery Date"; "Requested Delivery Date")
            {
                ApplicationArea = all;
            }
            field("Promised Delivery Date"; "Promised Delivery Date")
            {
                ApplicationArea = all;
            }

        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction in [ACTION::OK, ACTION::LookupOK] then
            CreateLines();
    end;

    var
        ShipmentSlipHeader_G: Record "TRANSP Shipment Slip Header";
        ShipmentSlipManagement_G: Codeunit "TRANSPShipment Slip Management";

    [Scope('OnPrem')]
    procedure SetShipmentSlip(var ShipmentSlipHeader_P: Record "TRANSP Shipment Slip Header")
    begin
        ShipmentSlipHeader_G.Get(ShipmentSlipHeader_P."No.");
    end;

    [Scope('OnPrem')]
    procedure CreateLines()
    begin
        CurrPage.SetSelectionFilter(Rec);
        Clear(ShipmentSlipManagement_G);
        ShipmentSlipManagement_G.SetShipmentSlip(ShipmentSlipHeader_G);
        ShipmentSlipManagement_G.CreateShipmentSlipLines(Rec);
    end;
}

