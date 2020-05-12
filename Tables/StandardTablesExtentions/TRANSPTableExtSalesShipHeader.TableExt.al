tableextension 84001 "TRANSPTableExt-SalesShipHeader" extends "Sales Shipment Header"
{
    fields
    {
        field(50025; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum ("Sales Shipment Line".Amount WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount';
            Description = 'WI004';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50035; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum ("Sales Shipment Line".Amount WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount Including VAT';
            Description = 'WI004';
            Editable = false;
            FieldClass = FlowField;
        }
        field(84000; "Assigned To Shpt. Slip"; Boolean)
        {
            Caption = 'Assigned To Shpt. Slip';
            DataClassification = CustomerContent;
            Description = 'WI004';
            Editable = false;
        }
        field(84001; "Shipment Slip No."; Code[20])
        {
            Caption = 'Shipment Slip No.';
            DataClassification = CustomerContent;
            Description = 'WI004';
            Editable = false;
            TableRelation = "TRANSP Shipment Slip Header";
        }
        field(84002; "Pallets Number"; Decimal)
        {
            Caption = 'Pallets Number';
            DataClassification = CustomerContent;
            Description = 'WI004';
            Editable = false;
        }
        field(84003; "Packages Number"; Decimal)
        {
            Caption = 'Packages Number';
            DataClassification = CustomerContent;
            Description = 'WI004';
            Editable = false;
        }
        field(84004; "Shpt. Slip Gross Weight"; Decimal)
        {
            Caption = 'Shpt. Slip Gross Weight';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Description = 'WI004';
            Editable = false;

            trigger OnValidate()
            var
                SalesShipmentHeaderToAssign_L: Record "Sales Shipment Header";
                ShipmentSlipLine_L: Record "TRANSP Shipment Slip Line";
            begin
                ShipmentSlipLine_L.Reset();
                ShipmentSlipLine_L.SetRange("Shipment Slip No.", "No.");
                if ShipmentSlipLine_L.FindSet() then
                    repeat
                        if SalesShipmentHeaderToAssign_L.Get(ShipmentSlipLine_L."Shipment No.") then begin
                            SalesShipmentHeaderToAssign_L."Assigned To Shpt. Slip" := true;
                            SalesShipmentHeaderToAssign_L."Shipment Slip No." := "No.";
                            SalesShipmentHeaderToAssign_L."Package Tracking No." := "Package Tracking No.";
                            SalesShipmentHeaderToAssign_L."Shipping Agent Code" := "Shipping Agent Code";
                            SalesShipmentHeaderToAssign_L."Pallets Number" := "Pallets Number";
                            SalesShipmentHeaderToAssign_L."Packages Number" := "Packages Number";
                            SalesShipmentHeaderToAssign_L.Modify();
                        end
                    until ShipmentSlipLine_L.Next() = 0;

            end;
        }
        field(84005; "Shpt. Slip Net Weight"; Decimal)
        {
            Caption = 'Shpt. Slip Net Weight';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Description = 'WI004';
            Editable = false;
        }
        field(84006; "Net Weight"; Decimal)
        {
            CalcFormula = Sum ("Sales Shipment Line"."Net Weight" WHERE("Document No." = FIELD("No.")));
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            Description = 'WI004';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

