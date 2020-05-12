tableextension 84003 "TRANSPTableExt-Sales&RecStUp" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50050; "Sales Def. Location"; Code[20])
        {
            Caption = 'Sales Def. Location';
            DataClassification = CustomerContent;
            Description = 'WI001';
            TableRelation = Location;
        }
        field(84000; "Tour Nos."; Code[20])
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            Caption = 'Tour Nos.';
            DataClassification = CustomerContent;
            Description = 'WI004';
            TableRelation = "No. Series";
        }
    }
}

