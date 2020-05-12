tableextension 84004 "TRANSP TableExt-Sales Header" extends "Sales Header"
{
    fields
    {
        field(84004; "Document Sender"; Code[30])
        {
            Caption = 'Document Sender';
            DataClassification = CustomerContent;
            Description = 'WI004';
            Editable = false;
            TableRelation = "User Setup";


        }
        field(84005; "Invoicing Status"; Option)
        {
            Caption = 'Invoicing Status';
            DataClassification = CustomerContent;
            Description = 'WI004';
            Editable = false;
            OptionCaption = 'Not Invoiced,Partially Invoiced,Completely Invoiced';
            OptionMembers = "Not Invoiced","Partially Invoiced","Completely Invoiced";
        }
        field(84006; "Shipment Status"; Option)
        {
            Caption = 'Shipment Status';
            DataClassification = CustomerContent;
            Description = 'WI004';
            Editable = false;
            OptionCaption = 'Not Shipped,Partially Shipped,Completely Shipped';
            OptionMembers = "Not Shipped","Partially Shipped","Completely Shipped";
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
        }
        field(84003; "Packages Number"; Decimal)
        {
            Caption = 'Packages Number';
            DataClassification = CustomerContent;
            Description = 'WI004';
        }
    }
}

