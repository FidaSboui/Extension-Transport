tableextension 84021 "TRANSP TableExt-Payment Line" extends "Payment Line"
{
    fields
    {
        field(84002; "WithHold Tax Amount"; Decimal)
        {
            Caption = 'WithHold Tax Amount';
            Description = 'WI004';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum ("TRANSP WithHolding Tax Entries"."WithHold Amount" WHERE("Payment Slip No." = FIELD("No."), "Payment Slip Line No." = FIELD("Line No."), Posted = FILTER(true)));
        }
        field(84000; "Header Account No."; Code[20])
        {
            Caption = 'Header Account No.';
            DataClassification = CustomerContent;
            Description = 'WI004';
            TableRelation = IF ("Header Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Header Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Header Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Header Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Header Account Type" = CONST("Fixed Asset")) "Fixed Asset";
        }
        field(84001; "Header Account Type"; Option)
        {
            Caption = 'Account Type Header';
            DataClassification = CustomerContent;
            Description = 'WI004';
            Editable = true;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(84003; "Payment Title No."; Text[30])
        {
            Caption = 'Payment Title No.';
            DataClassification = CustomerContent;
            Description = 'WI004';
            TableRelation = "TRANSP Bank Checks"."Check No." WHERE("Bank Account No." = FIELD("Header Account No."),
                                                             "Payment Slip No." = FILTER(''),
                                                             "Cancelled Check" = FILTER(false));
            ValidateTableRelation = false;
        }
        field(84004; "Payment Title Bank Account"; Text[30])
        {
            Caption = 'Payment Title Bank Account';
            DataClassification = CustomerContent;
            Description = 'WI004';
        }
        field(84005; "Payment Line Description"; Text[100])
        {
            Caption = 'Payment Line Description';
            DataClassification = CustomerContent;
            Description = 'WI004';
        }
    }
}

