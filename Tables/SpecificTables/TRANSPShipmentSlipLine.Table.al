table 84001 "TRANSP Shipment Slip Line"
{
    Caption = 'Shipment Slip Line';

    fields
    {
        field(1; "Shipment Slip No."; Code[20])
        {
            Caption = 'Shipment Slip No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Order No."; Code[20])
        {
            Caption = 'N° commande';
            DataClassification = CustomerContent;
        }
        field(4; "Shipment No."; Code[20])
        {
            Caption = 'N° expédition';
            DataClassification = CustomerContent;
        }
        field(11; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(12; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(13; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
            DataClassification = CustomerContent;
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
            DataClassification = CustomerContent;
        }
        field(15; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
            DataClassification = CustomerContent;
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
            DataClassification = CustomerContent;
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            DataClassification = CustomerContent;
            TableRelation = IF ("Ship-to Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Ship-to Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Ship-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(18; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            DataClassification = CustomerContent;
            TableRelation = "Ship-to Address".Code;
        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(60; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            DataClassification = CustomerContent;
            TableRelation = IF ("Ship-to Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Ship-to Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Ship-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
            DataClassification = CustomerContent;
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(107; "Pallets Number"; Decimal)
        {
            Caption = 'Pallets Number';
            DataClassification = CustomerContent;
        }
        field(108; "Packages Number"; Decimal)
        {
            Caption = 'Packages Number';
            DataClassification = CustomerContent;
        }
        field(109; Comment; Text[250])
        {
            Caption = 'Commentaire';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Shipment Slip No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        SalesShipmentHeaderToAssign_L: Record "Sales Shipment Header";
        ShipmentSlipLine_L: Record "TRANSP Shipment Slip Line";
    begin
        if SalesShipmentHeaderToAssign_L.Get("Shipment No.") then begin
            SalesShipmentHeaderToAssign_L."Assigned To Shpt. Slip" := false;
            SalesShipmentHeaderToAssign_L."Shipment Slip No." := '';
            SalesShipmentHeaderToAssign_L."Package Tracking No." := '';
            SalesShipmentHeaderToAssign_L."Shipping Agent Code" := '';
            SalesShipmentHeaderToAssign_L."Pallets Number" := 0;
            SalesShipmentHeaderToAssign_L."Packages Number" := 0;
            SalesShipmentHeaderToAssign_L."Shpt. Slip Gross Weight" := 0;
            SalesShipmentHeaderToAssign_L."Shpt. Slip Net Weight" := 0;
            SalesShipmentHeaderToAssign_L.Modify();
        end;

        ShipmentSlipLine_L.Reset();
        ShipmentSlipLine_L.SetRange("Shipment Slip No.", "Shipment Slip No.");
        if ShipmentSlipLine_L.FindSet() then
            repeat
                if SalesShipmentHeaderToAssign_L.Get(ShipmentSlipLine_L."Shipment No.") then begin
                    SalesShipmentHeaderToAssign_L."Shpt. Slip Net Weight" -= "Net Weight";
                    SalesShipmentHeaderToAssign_L.Modify();
                end
            until ShipmentSlipLine_L.Next() = 0;

    end;
}

