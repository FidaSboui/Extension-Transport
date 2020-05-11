table 84021 "TRANSP WithHolding Tax"
{
    // | B2M-IT - Pôle Expertise Navision                                                                                |
    // | www.b2m-it.com                                                                                                  |
    // +-----------------------------------------------------------------------------------------------------------------+
    // Trigramme   Nom & Prénom
    // ---------   -----------------
    // MMA         Mehdi MOALLA
    // 
    // WorkItem  No.  Date       Sign  Description
    // -------- ---- ----------  ----- -------------------------------------------------------------
    // 15-BPA01 001  15.06.2015  MMA   Add new Object

    Caption = 'WithHolding Taxes';
    //DrillDownPageID = 81000;
    //LookupPageID = 81000;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "% Tax"; Decimal)
        {
            Caption = '% Tax';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(4; "Withholding Tax G/L Acc. No."; Code[20])
        {
            Caption = 'Withholding Tax G/L Acc. No.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Retenue à la source,Retenue de garantie';
            OptionMembers = "Withholding tax","Retention money";
            DataClassification = CustomerContent;
        }
        field(7; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(18; "Source Code"; Code[20])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code".Code;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Type, "No.")
        {
            Clustered = true;
        }
        key(Key2; "No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, "% Tax")
        {
        }
    }
}

