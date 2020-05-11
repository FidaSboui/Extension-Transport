tableextension 84002 "TRANSP TableExt SalesShipLines" extends "Sales Shipment Line"
{
    fields
    {
        field(50020; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
            DataClassification = CustomerContent;
            Description = 'WI001';
        }
        field(50025; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = CustomerContent;
            Description = 'WI004';
            Editable = true;
        }
        field(50030; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
            DataClassification = CustomerContent;
            Description = 'WI001';
            Editable = true;
        }
        field(50035; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            DataClassification = CustomerContent;
            Description = 'WI001';
            Editable = true;
        }
        field(75017; "Advance / Tax Amount"; Decimal)
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

