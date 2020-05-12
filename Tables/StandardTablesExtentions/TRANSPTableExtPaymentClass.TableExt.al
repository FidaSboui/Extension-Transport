tableextension 84041 "TRANSP TableExt Payment Class" extends "Payment Class"
{
    fields
    {
        field(84000; "WithHolding Tax Payment"; Boolean)
        {
            Caption = 'WithHoldingTax Payment';
            DataClassification = CustomerContent;
            Description = 'WI004';
        }
    }
}

