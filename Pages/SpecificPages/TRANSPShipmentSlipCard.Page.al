page 84001 "TRANSP Shipment Slip Card"
{

    Caption = 'Shipment Slip Card';
    PageType = Card;
    SourceTable = "TRANSP Shipment Slip Header";
    PromotedActionCategories = 'New,Process,Report,Manage,,,,';
    UsageCategory = Documents;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group("Général")
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting date"; "Posting date")
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
                field("Gross Weight"; "Gross Weight")
                {
                    ApplicationArea = all;
                }
                field("Net Weight"; "Net Weight")
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
            part(ShipmentSlipLines; "TRANSP Shipment Slip Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Shipment Slip No." = FIELD("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1000000034)
            {
                Caption = 'Manage';
                Image = Setup;
                action(GetSalesShipment)
                {
                    ApplicationArea = all;
                    Caption = 'Get &Sales Shipment';
                    Ellipsis = false;
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    trigger OnAction()
                    begin
                        TestField(Status, Status::Open);
                        if "Customer No." <> '' then
                            CODEUNIT.Run(CODEUNIT::"TRANSPShipment Slip Management", Rec)
                        else
                            Error(ChooseCustMsg);
                    end;
                }
                action("Bordereaux de livraison")
                {
                    ApplicationArea = all;
                    Caption = 'Bordereaux de livraison';
                    Image = PostedShipment;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ShipmentSlipHeader_L: Record "TRANSP Shipment Slip Header";
                    begin
                        ShipmentSlipHeader_L.Reset();
                        ShipmentSlipHeader_L.SetRange("No.", "No.");
                        REPORT.Run(84000, true, true, ShipmentSlipHeader_L);
                        Status := Status::Printed;
                        Modify()
                    end;
                }
            }
            group(Action1000000031)
            {
                Caption = 'Release/Reopen';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = all;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    PromotedOnly = true;
                    trigger OnAction()
                    begin
                        TestField(Status, Status::Open);
                        Status := Status::Released;
                        Modify();
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = all;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Status := Status::Open;
                        Modify();
                    end;
                }
            }
        }
    }

    var
        ChooseCustMsg: Label 'Please choose a customer';
}

