table 84002 "TRANSP Bank Checks"
{
    Caption = 'Bank Check';
    //DrillDownPageID = 81002;
    //LookupPageID = 81002;


    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            NotBlank = true;
            TableRelation = "Bank Account";
            DataClassification = CustomerContent;

        }
        field(2; "Check No."; Text[30])
        {
            Caption = 'Check No.';
            DataClassification = CustomerContent;
        }
        field(3; "Payment Slip No."; Code[20])
        {
            Caption = 'Payment Slip No';
            DataClassification = CustomerContent;
        }
        field(4; "Payment Slip Line No."; Integer)
        {
            Caption = 'Payment Slip Line No';
            DataClassification = CustomerContent;
        }
        field(5; "Barré"; Boolean)
        {
            Caption = 'Crossed';
            DataClassification = CustomerContent;
        }
        field(6; "Cancelled Check"; Boolean)
        {
            Caption = 'Cancelled Check';
            DataClassification = CustomerContent;
        }
        field(7; "Account Type"; Option)
        {
            CalcFormula = Lookup ("Payment Line"."Account Type" WHERE("No." = FIELD("Payment Slip No."),
                                                                      "Line No." = FIELD("Payment Slip Line No.")));
            Caption = 'Account Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(8; "Account No."; Code[20])
        {
            CalcFormula = Lookup ("Payment Line"."Account No." WHERE("No." = FIELD("Payment Slip No."),
                                                                     "Line No." = FIELD("Payment Slip Line No.")));
            Caption = 'Account No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Drawee Reference"; Text[100])
        {
            CalcFormula = Lookup ("Payment Line"."Drawee Reference" WHERE("No." = FIELD("Payment Slip No."),
                                                                          "Line No." = FIELD("Payment Slip Line No.")));
            Caption = 'Drawee Reference';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Check No.", "Bank Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Bank Account No.", "Check No.", "Payment Slip No.", "Payment Slip Line No.")
        {
        }
    }

}

