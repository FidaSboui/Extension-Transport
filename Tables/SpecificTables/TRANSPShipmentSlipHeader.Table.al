table 84000 "TRANSP Shipment Slip Header"
{
    Caption = 'Shipment Slip Header';
    DrillDownPageID = "TRANSP Shipment Slip List";
    LookupPageID = "TRANSP Shipment Slip List";
    Permissions = TableData "Sales Shipment Header" = rimd,
                  TableData "Sales Shipment Line" = rimd;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GetTourSetup();
                    NoSeriesMgt_G.TestManual(SalesSetup_G."Tour Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(3; "Departure Time"; Time)
        {
            Caption = 'Departure time';
            DataClassification = CustomerContent;
        }
        field(4; "End of order Time"; Time)
        {
            Caption = 'End of order Time';
            DataClassification = CustomerContent;
        }
        field(6; "Posting date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(8; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Open,Released,Printed';
            OptionMembers = Open,Released,Printed;
        }
        field(9; "Created Date-Time"; DateTime)
        {
            Caption = 'Created Date-Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Created By UserID"; Code[50])
        {
            Caption = 'Created By UserID';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "User Setup";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(11; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;

            trigger OnValidate()
            var
                Customer_L: Record Customer;
            begin
                if Customer_L.Get("Customer No.") then
                    "Customer Name" := Customer_L.Name;
            end;
        }
        field(12; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(13; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
            DataClassification = CustomerContent;
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
            DataClassification = CustomerContent;
        }
        field(15; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
            DataClassification = CustomerContent;
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
            DataClassification = CustomerContent;
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            DataClassification = CustomerContent;
            TableRelation = IF ("Ship-to Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Ship-to Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Ship-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(18; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            DataClassification = CustomerContent;
            TableRelation = "Ship-to Address".Code;
        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                ShipmentSlipLine_L: Record "TRANSP Shipment Slip Line";
                SalesShipmentHeaderToAssign_L: Record "Sales Shipment Header";
            begin
                ShipmentSlipLine_L.Reset();
                ShipmentSlipLine_L.SetRange("Shipment Slip No.", "No.");
                if ShipmentSlipLine_L.FindSet() then
                    repeat
                        if SalesShipmentHeaderToAssign_L.Get(ShipmentSlipLine_L."Shipment No.") then begin
                            SalesShipmentHeaderToAssign_L."Shpt. Slip Gross Weight" := "Gross Weight";
                            SalesShipmentHeaderToAssign_L.Modify();
                        end
                    until ShipmentSlipLine_L.Next() = 0;

            end;
        }
        field(35; "Net Weight"; Decimal)
        {
            CalcFormula = Sum ("TRANSP Shipment Slip Line"."Net Weight" WHERE("Shipment Slip No." = FIELD("No.")));
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            DataClassification = CustomerContent;
            TableRelation = IF ("Ship-to Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Ship-to Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Ship-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
            DataClassification = CustomerContent;
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(105; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            var
                ShipmentSlipLine_L: Record "TRANSP Shipment Slip Line";
                SalesShipmentHeaderToAssign_L: Record "Sales Shipment Header";
            begin
                ShipmentSlipLine_L.Reset();
                ShipmentSlipLine_L.SetRange("Shipment Slip No.", "No.");
                if ShipmentSlipLine_L.FindSet() then
                    repeat
                        if SalesShipmentHeaderToAssign_L.Get(ShipmentSlipLine_L."Shipment No.") then begin
                            SalesShipmentHeaderToAssign_L."Shipping Agent Code" := "Shipping Agent Code";
                            SalesShipmentHeaderToAssign_L.Modify();
                        end
                    until ShipmentSlipLine_L.Next() = 0;

            end;
        }
        field(106; "Package Tracking No."; Text[30])
        {
            Caption = 'Package Tracking No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ShipmentSlipLine_L: Record "TRANSP Shipment Slip Line";
                SalesShipmentHeaderToAssign_L: Record "Sales Shipment Header";
            begin
                ShipmentSlipLine_L.Reset();
                ShipmentSlipLine_L.SetRange("Shipment Slip No.", "No.");
                if ShipmentSlipLine_L.FindSet() then
                    repeat
                        if SalesShipmentHeaderToAssign_L.Get(ShipmentSlipLine_L."Shipment No.") then begin
                            SalesShipmentHeaderToAssign_L."Package Tracking No." := "Package Tracking No.";
                            SalesShipmentHeaderToAssign_L.Modify();
                        end
                    until ShipmentSlipLine_L.Next() = 0;

            end;
        }
        field(107; "Pallets Number"; Decimal)
        {
            Caption = 'Pallets Number';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ShipmentSlipLine_L: Record "TRANSP Shipment Slip Line";
                SalesShipmentHeaderToAssign_L: Record "Sales Shipment Header";
            begin
                ShipmentSlipLine_L.Reset();
                ShipmentSlipLine_L.SetRange("Shipment Slip No.", "No.");
                if ShipmentSlipLine_L.FindSet() then
                    repeat
                        if SalesShipmentHeaderToAssign_L.Get(ShipmentSlipLine_L."Shipment No.") then begin
                            SalesShipmentHeaderToAssign_L."Pallets Number" := "Pallets Number";
                            SalesShipmentHeaderToAssign_L.Modify();
                        end
                    until ShipmentSlipLine_L.Next() = 0;

            end;
        }
        field(108; "Packages Number"; Decimal)
        {
            Caption = 'Packages Number';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ShipmentSlipLine_L: Record "TRANSP Shipment Slip Line";
                SalesShipmentHeaderToAssign_L: Record "Sales Shipment Header";
            begin
                ShipmentSlipLine_L.Reset();
                ShipmentSlipLine_L.SetRange("Shipment Slip No.", "No.");
                if ShipmentSlipLine_L.FindSet() then
                    repeat
                        if SalesShipmentHeaderToAssign_L.Get(ShipmentSlipLine_L."Shipment No.") then begin
                            SalesShipmentHeaderToAssign_L."Packages Number" := "Packages Number";
                            SalesShipmentHeaderToAssign_L.Modify();
                        end
                    until ShipmentSlipLine_L.Next() = 0;
            end;
        }
        field(109; Comment; Text[250])
        {
            Caption = 'Commentaire';
            DataClassification = CustomerContent;
        }
        field(110; "Line Numbre"; Integer)
        {
            CalcFormula = Count ("TRANSP Shipment Slip Line" WHERE("Shipment Slip No." = FIELD("No.")));
            Caption = 'Line Numbre';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ShipmentSlipLine_L: Record "TRANSP Shipment Slip Line";
    begin
        TestField(Status, Status::Open);

        ShipmentSlipLine_L.Reset();
        ShipmentSlipLine_L.SetRange("Shipment Slip No.", "No.");
        ShipmentSlipLine_L.Delete(true);
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            GetTourSetup();
            SalesSetup_G.TestField("Tour Nos.");
            NoSeriesMgt_G.InitSeries(SalesSetup_G."Tour Nos.", xRec."No. Series", "Posting date", "No.", "No. Series");
        end;
        if ("Posting date" = 0D) then
            "Posting date" := WorkDate();
        "Created Date-Time" := RoundDateTime(CurrentDateTime, 60000);
        "Created By UserID" := UserId;
    end;

    var
        SalesSetup_G: Record "Sales & Receivables Setup";
        NoSeriesMgt_G: Codeunit NoSeriesManagement;
        HasSalesSetup_G: Boolean;


    local procedure GetTourSetup()
    begin
        if not HasSalesSetup_G then begin
            SalesSetup_G.Get();
            HasSalesSetup_G := true;
        end;
    end;

    [Scope('OnPrem')]
    procedure AssistEdit(OldShtSlipHdr_P: Record "TRANSP Shipment Slip Header"): Boolean
    var
        ShipmentSlipHeader_L: Record "TRANSP Shipment Slip Header";
    begin
        with ShipmentSlipHeader_L do begin
            ShipmentSlipHeader_L := Rec;
            SalesSetup_G.Get();
            SalesSetup_G.TestField(SalesSetup_G."Tour Nos.");
            if NoSeriesMgt_G.SelectSeries(SalesSetup_G."Tour Nos.", OldShtSlipHdr_P."No. Series", "No. Series") then begin
                NoSeriesMgt_G.SetSeries("No.");
                Rec := ShipmentSlipHeader_L;
                exit(true);
            end;
        end;
    end;
}

