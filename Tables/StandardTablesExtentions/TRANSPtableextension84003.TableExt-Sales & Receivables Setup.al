tableextension 84003 tableextension84003 extends "Sales & Receivables Setup"
{
    fields
    {
        field(50050; "Sales Def. Location"; Code[20])
        {
            Caption = 'Sales Def. Location';
            DataClassification = ToBeClassified;
            Description = 'WI001';
            TableRelation = Location;
        }
        field(84000; "Tour Nos."; Code[20])
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            Caption = 'Tour Nos.';
            DataClassification = ToBeClassified;
            Description = 'WI004';
            TableRelation = "No. Series";
        }
    }
}

