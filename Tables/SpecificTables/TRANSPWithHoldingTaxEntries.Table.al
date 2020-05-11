table 84020 "TRANSP WithHolding Tax Entries"
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

    Caption = 'WithHolding Tax Entries';

    fields
    {
        field(1; "Payment Slip No."; Code[30])
        {
            Caption = 'Payment Slip No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Vendor/Customer Entry No." = 0 then begin
                    PaymentLine_G.Reset();
                    PaymentLine_G.SetRange("No.", "Payment Slip No.");
                    PaymentLine_G.SetRange("Line No.", "Payment Slip Line No.");
                    if PaymentLine_G.FindFirst() then begin
                        "Invoice Remaining Amount" := Abs(PaymentLine_G.Amount);
                        "Payment Slip Line No." := PaymentLine_G."Line No.";
                        "Base Amount" := Abs(PaymentLine_G.Amount);
                        WithHoldTax_G.Reset();
                        WithHoldTax_G.SetRange(WithHoldTax_G."Payment Slip No.", "Payment Slip No.");
                        WithHoldTax_G.SetRange(WithHoldTax_G."Payment Slip Line No.", "Payment Slip Line No.");
                        if WithHoldTax_G.FindSet() then
                            repeat
                                "Base Amount" -= WithHoldTax_G."Base Amount";
                            until WithHoldTax_G.Next() = 0;
                        "Remaining Amount" := "Base Amount";
                    end;
                end;
            end;
        }
        field(2; "WithHold Tax No."; Code[20])
        {
            Caption = 'WithHold Tax No.';
            TableRelation = "TRANSP WithHolding Tax"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField(Posted, false);
                WithHoldTaxes_G.Get(WithHoldTaxes_G.Type::"Withholding tax", "WithHold Tax No.");
                "WithHold Tax %" := WithHoldTaxes_G."% Tax";
                Validate("Base Amount");
                if "Invoice No." = '' then
                    "WithHold Tax per Payment" := true
                else
                    "WithHold Tax per Document" := true
            end;
        }
        field(3; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; "Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Base Amount';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                AmountL: Decimal;
            begin
                TestField(Posted, false);

                AmountL := 0;
                WithHoldTax_G.Reset();
                WithHoldTax_G.SetRange(WithHoldTax_G."Payment Slip No.", "Payment Slip No.");
                WithHoldTax_G.SetRange(WithHoldTax_G."Payment Slip Line No.", "Payment Slip Line No.");
                WithHoldTax_G.SetFilter(WithHoldTax_G."WithHold Tax No.", '<>%1', WithHoldTax_G."WithHold Tax No.");
                if "Vendor/Customer Entry No." <> 0 then
                    WithHoldTax_G.SetRange("Invoice No.", "Invoice No.");
                if WithHoldTax_G.FindSet() then
                    repeat
                        AmountL += WithHoldTax_G."Base Amount";
                    until WithHoldTax_G.Next() = 0;

                if "Base Amount" > "Remaining Amount" then
                    Error(DepAmountErr, "Base Amount" - "Remaining Amount");

                if "WithHold Tax No." <> '' then begin
                    WithHoldTaxes_G.Get(0, "WithHold Tax No.");
                    if "Currency Code" <> '' then begin
                        Currency_G.Get("Currency Code");
                        "WithHold Tax %" := WithHoldTaxes_G."% Tax";
                        "WithHold Amount" := Round("Base Amount" * ("WithHold Tax %" / 100), Currency_G."Amount Rounding Precision")
                    end
                    else begin
                        GLSetup_G.Get();
                        "WithHold Tax %" := WithHoldTaxes_G."% Tax";
                        "WithHold Amount" := Round("Base Amount" * ("WithHold Tax %" / 100), GLSetup_G."Amount Rounding Precision")
                    end;
                    "Net Amount" := "Base Amount" - "WithHold Amount";
                end;
            end;
        }
        field(5; "WithHold Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'WithHold Amount';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(6; "Net Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Net Amount';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(7; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(8; "WithHold Tax %"; Decimal)
        {
            Caption = 'WithHold Tax %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Vendor/Customer Entry No."; Integer)
        {
            Caption = 'Vendor/Customer Entry No.';
            Editable = false;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                VendorEntries_G.Get("Vendor/Customer Entry No.");
                "Invoice No." := VendorEntries_G."Document No.";
                "Base Amount" := Abs(VendorEntries_G."Amount to Apply");

                WithHoldTax_G.Reset();
                WithHoldTax_G.SetRange(WithHoldTax_G."Payment Slip No.", "Payment Slip No.");
                WithHoldTax_G.SetRange(WithHoldTax_G."Payment Slip Line No.", "Payment Slip Line No.");

                WithHoldTax_G.SetRange("Vendor/Customer Entry No.", "Vendor/Customer Entry No.");
                "Invoice Remaining Amount" := Abs(VendorEntries_G."Amount to Apply");
                if WithHoldTax_G.FindSet() then
                    repeat
                        "Base Amount" -= WithHoldTax_G."Base Amount";
                    until WithHoldTax_G.Next() = 0;

                "Remaining Amount" := "Base Amount";
                if "Base Amount" < 0 then
                    Error(NegAmountErr)
            end;
        }
        field(10; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(11; "Invoice Remaining Amount"; Decimal)
        {
            Caption = 'Invoice Remaining Amount';
            DataClassification = CustomerContent;
        }
        field(12; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(13; "WithHold Tax per Document"; Boolean)
        {
            Caption = 'WithHold Tax per Document';
            DataClassification = CustomerContent;
        }
        field(14; "WithHold Tax per Payment"; Boolean)
        {
            Caption = 'WithHold Tax per Payment';
            DataClassification = CustomerContent;
        }
        field(15; "Payment Slip Line No."; Integer)
        {
            Caption = 'Payment Slip Line No.';
            DataClassification = CustomerContent;
        }
        field(16; "Remaining Amount"; Decimal)
        {
            Caption = 'Remaining Amount';
            DataClassification = CustomerContent;
        }
        field(17; "Posting Date"; Date)
        {
            CalcFormula = Lookup ("Payment Line"."Posting Date" WHERE("No." = FIELD("Payment Slip No."),
                                                                      "Line No." = FIELD("Payment Slip Line No.")));
            Caption = 'Posting Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Vendor Name"; Text[50])
        {
            CalcFormula = Lookup (Vendor.Name WHERE("No." = FIELD("Vendor No.")));
            Caption = 'Nom Fournisseur';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Vendor;
        }
    }

    keys
    {
        key(Key1; "Payment Slip No.", "Payment Slip Line No.", "Vendor No.", "Vendor/Customer Entry No.", "WithHold Tax No.")
        {
            Clustered = true;
            SumIndexFields = "WithHold Amount";
        }
        key(Key2; "Payment Slip No.", "Payment Slip Line No.", Posted)
        {
            SumIndexFields = "WithHold Amount";
        }
        key(Key3; "WithHold Tax %")
        {
        }
    }

    fieldgroups
    {
    }

    var
        WithHoldTaxes_G: Record "TRANSP WithHolding Tax";
        VendorEntries_G: Record "Vendor Ledger Entry";
        Currency_G: Record Currency;
        GLSetup_G: Record "General Ledger Setup";
        WithHoldTax_G: Record "TRANSP WithHolding Tax Entries";
        PaymentLine_G: Record "Payment Line";
        NegAmountErr: Label 'Vous ne pouvez pas créer une autre ligne retenu à la source, le montant est négatif';
        DepAmountErr: Label 'Vous avez depassé le montant brut disponible de %1', comment = '%1 = Amount';

    [Scope('OnPrem')]
    procedure PostEntry()
    var
        WithHoldTaxEntries_L: Record "TRANSP WithHolding Tax Entries";
        PaymentHeader_L: Record "Payment Header";
        PaymentClass_L: Record "Payment Class";
        WithHoldingTax_L: Record "TRANSP WithHolding Tax";
    begin
        WithHoldTaxEntries_L.Reset();
        WithHoldTaxEntries_L.SetRange(WithHoldTaxEntries_L."Payment Slip No.", "Payment Slip No.");
        WithHoldTaxEntries_L.SetRange(WithHoldTaxEntries_L."Payment Slip Line No.", "Payment Slip Line No.");
        if "Invoice No." <> '' then
            WithHoldTaxEntries_L.SetRange("Invoice No.", "Invoice No.");
        if WithHoldTaxEntries_L.FindSet() then
            repeat
                if WithHoldTaxEntries_L.Posted then
                    WithHoldTaxEntries_L.Posted := false
                else begin
                    WithHoldTaxEntries_L.Posted := true;
                    PaymentHeader_L.Get("Payment Slip No.");
                    PaymentClass_L.Get(PaymentHeader_L."Payment Class");
                    if PaymentClass_L."WithHolding Tax Payment" then begin
                        WithHoldingTax_L.Get(WithHoldingTax_L.Type::"Withholding tax", WithHoldTaxEntries_L."WithHold Tax No.");
                        PaymentHeader_L.Validate("Account Type", PaymentHeader_L."Account Type"::"G/L Account");
                        PaymentHeader_L.Validate("Account No.", WithHoldingTax_L."Withholding Tax G/L Acc. No.");
                        PaymentHeader_L.Modify();
                    end;
                end;
                WithHoldTaxEntries_L.Modify();
            until WithHoldTaxEntries_L.Next() = 0;
    end;
}

