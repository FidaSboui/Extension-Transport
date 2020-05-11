codeunit 84000 "TRANSPShipment Slip Management"
{
    Permissions = TableData "Sales Shipment Header" = rimd,
                  TableData "Sales Shipment Line" = rimd;
    TableNo = "TRANSP Shipment Slip Header";

    trigger OnRun()
    var
        SalesShipmentHeader_L: Record "Sales Shipment Header";
        GetSalesShipmentOrder_L: Page "TRANSPGet Sales Shipment Order";
    begin
        ShipmentSlipHeader_G.Get(Rec."No.");
        SalesShipmentHeader_L.Reset();
        SalesShipmentHeader_L.SetRange("Sell-to Customer No.", ShipmentSlipHeader_G."Customer No.");
        SalesShipmentHeader_L.SetRange("Assigned To Shpt. Slip", false);
        if SalesShipmentHeader_L.FindSet() then begin
            Clear(GetSalesShipmentOrder_L);
            GetSalesShipmentOrder_L.SetTableView(SalesShipmentHeader_L);
            GetSalesShipmentOrder_L.SetShipmentSlip(ShipmentSlipHeader_G);
            GetSalesShipmentOrder_L.LookupMode := true;
            if GetSalesShipmentOrder_L.RunModal() <> ACTION::Cancel then;
        end else
            Error(NoBLMsg);
    end;

    var
        ShipmentSlipHeader_G: Record "TRANSP Shipment Slip Header";
        NoBLMsg: Label 'Il n''y pas de BL pour ce client non attribuée';

    [Scope('OnPrem')]
    procedure SetShipmentSlip(var ShipmentSlipHeader_P: Record "TRANSP Shipment Slip Header")
    begin
        ShipmentSlipHeader_G.Get(ShipmentSlipHeader_P."No.");
    end;

    [Scope('OnPrem')]
    procedure CreateShipmentSlipLines(var SalesShipmentHeader_P: Record "Sales Shipment Header")
    var

        SalesShipmentLine_L: Record "Sales Shipment Line";
        SalesShipmentHeaderToAssign_L: Record "Sales Shipment Header";
        ShipmentSlipLine_L: Record "TRANSP Shipment Slip Line";
        ShipmentSlipNo_L: Integer;
    begin
        ShipmentSlipLine_L.Reset();
        ShipmentSlipLine_L.SetRange("Shipment Slip No.", ShipmentSlipHeader_G."No.");
        ShipmentSlipLine_L.Ascending;
        if ShipmentSlipLine_L.FindLast() then
            ShipmentSlipNo_L := ShipmentSlipLine_L."Line No.";

        if SalesShipmentHeader_P.FindSet() then
            repeat
                ShipmentSlipLine_L.Init();
                ShipmentSlipNo_L += 10000;
                ShipmentSlipLine_L."Shipment Slip No." := ShipmentSlipHeader_G."No.";
                ShipmentSlipLine_L."Line No." := ShipmentSlipNo_L;
                ShipmentSlipLine_L."Order No." := SalesShipmentHeader_P."Order No.";
                ShipmentSlipLine_L."Shipment No." := SalesShipmentHeader_P."No.";
                ShipmentSlipLine_L."Customer No." := SalesShipmentHeader_P."Sell-to Customer No.";
                ShipmentSlipLine_L."Customer Name" := SalesShipmentHeader_P."Sell-to Customer Name";
                ShipmentSlipLine_L."Ship-to Name" := SalesShipmentHeader_P."Ship-to Name";
                ShipmentSlipLine_L."Ship-to Name 2" := SalesShipmentHeader_P."Ship-to Name 2";
                ShipmentSlipLine_L."Ship-to Address" := SalesShipmentHeader_P."Ship-to Address";
                ShipmentSlipLine_L."Ship-to Address 2" := SalesShipmentHeader_P."Ship-to Address 2";
                ShipmentSlipLine_L."Ship-to City" := SalesShipmentHeader_P."Ship-to City";
                ShipmentSlipLine_L."Ship-to Code" := SalesShipmentHeader_P."Ship-to Code";
                SalesShipmentHeader_P.CalcFields(Amount, "Amount Including VAT");
                ShipmentSlipLine_L.Amount := SalesShipmentHeader_P.Amount;
                ShipmentSlipLine_L."Amount Including VAT" := SalesShipmentHeader_P."Amount Including VAT";
                ShipmentSlipLine_L.Insert();
                SalesShipmentLine_L.Reset();
                SalesShipmentLine_L.SetRange("Document No.", SalesShipmentHeader_P."No.");
                if SalesShipmentLine_L.FindSet() then
                    repeat
                        ShipmentSlipLine_L."Net Weight" += SalesShipmentLine_L."Net Weight";
                        ShipmentSlipLine_L.Modify();
                    until SalesShipmentLine_L.Next() = 0;

            until SalesShipmentHeader_P.Next() = 0;


        ShipmentSlipLine_L.Reset();
        ShipmentSlipLine_L.SetRange("Shipment Slip No.", ShipmentSlipHeader_G."No.");
        if ShipmentSlipLine_L.FindSet() then
            repeat
                if SalesShipmentHeaderToAssign_L.Get(ShipmentSlipLine_L."Shipment No.") then
                    if not SalesShipmentHeaderToAssign_L."Assigned To Shpt. Slip" then begin
                        SalesShipmentHeaderToAssign_L."Assigned To Shpt. Slip" := true;
                        SalesShipmentHeaderToAssign_L."Shipment Slip No." := ShipmentSlipHeader_G."No.";
                        SalesShipmentHeaderToAssign_L."Package Tracking No." := ShipmentSlipHeader_G."Package Tracking No.";
                        SalesShipmentHeaderToAssign_L."Shipping Agent Code" := ShipmentSlipHeader_G."Shipping Agent Code";
                        SalesShipmentHeaderToAssign_L."Pallets Number" := ShipmentSlipHeader_G."Pallets Number";
                        SalesShipmentHeaderToAssign_L."Packages Number" := ShipmentSlipHeader_G."Packages Number";
                        SalesShipmentHeaderToAssign_L."Shpt. Slip Gross Weight" := ShipmentSlipHeader_G."Gross Weight";
                        ShipmentSlipHeader_G.CalcFields("Net Weight");
                        SalesShipmentHeaderToAssign_L."Shpt. Slip Net Weight" := ShipmentSlipHeader_G."Net Weight";
                        SalesShipmentHeaderToAssign_L.Modify();
                    end

            until ShipmentSlipLine_L.Next() = 0;

    end;
}

