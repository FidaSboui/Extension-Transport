tableextension 84004 tableextension84004 extends "Sales Header"
{
    fields
    {
        field(80000; "Document Sender"; Code[30])
        {
            Caption = 'Document Sender';
            DataClassification = ToBeClassified;
            Description = 'WI004';
            Editable = false;
            TableRelation = "User Setup";

            trigger OnValidate()
            var
                Purchline_L: Record "Purchase Line";
            begin
            end;
        }
        field(80010; "Invoicing Status"; Option)
        {
            Caption = 'Invoicing Status';
            DataClassification = ToBeClassified;
            Description = 'WI004';
            Editable = false;
            OptionCaption = 'Not Invoiced,Partially Invoiced,Completely Invoiced';
            OptionMembers = "Not Invoiced","Partially Invoiced","Completely Invoiced";
        }
        field(80011; "Shipment Status"; Option)
        {
            Caption = 'Shipment Status';
            DataClassification = ToBeClassified;
            Description = 'WI004';
            Editable = false;
            OptionCaption = 'Not Shipped,Partially Shipped,Completely Shipped';
            OptionMembers = "Not Shipped","Partially Shipped","Completely Shipped";
        }
        field(84000; "Assigned To Shpt. Slip"; Boolean)
        {
            Caption = 'Assigned To Shpt. Slip';
            DataClassification = ToBeClassified;
            Description = 'WI004';
            Editable = false;
        }
        field(84001; "Shipment Slip No."; Code[20])
        {
            Caption = 'Shipment Slip No.';
            DataClassification = ToBeClassified;
            Description = 'WI004';
            Editable = false;
            TableRelation = "Shipment Slip Header";
        }
        field(84002; "Pallets Number"; Decimal)
        {
            Caption = 'Pallets Number';
            DataClassification = ToBeClassified;
            Description = 'WI004';
        }
        field(84003; "Packages Number"; Decimal)
        {
            Caption = 'Packages Number';
            DataClassification = ToBeClassified;
            Description = 'WI004';
        }
    }
}

