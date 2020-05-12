tableextension 84002 "TRANSP TableExt SalesShipLines" extends "Sales Shipment Line"
{
    fields
    {
        field(84000; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
            DataClassification = CustomerContent;
            Description = 'WI001';
        }
        field(84001; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = CustomerContent;
            Description = 'WI004';
            Editable = true;
        }
        field(84002; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
            DataClassification = CustomerContent;
            Description = 'WI001';
            Editable = true;
        }
        field(84003; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            DataClassification = CustomerContent;
            Description = 'WI001';
            Editable = true;
        }
        field(84004; "Advance / Tax Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Advance / Tax';
            DataClassification = CustomerContent;
            Description = 'Advance Tax | WI001';
            Editable = false;
        }
    }
}

