report 84000 "TRANSP Trade effect"
{
    // +----------------------------------------------------------------------------------------------------------------+
    // | B2M-IT - Pôle Expertise Navision                                                                                |
    // | www.b2m-it.com                                                                                                  |
    // +-----------------------------------------------------------------------------------------------------------------+
    // Trigramme   Nom & Prénom
    // ---------   -----------------
    // MMA         MOALLA Mehdi
    // 
    // No.  Date        Sign  Description
    // ---- ----------  ----- ------------------------------------------------------------------
    // 001  22.04.2012  MMA   Nouvel objet
    DefaultLayout = RDLC;
    RDLCLayout = '.\Layout\Tradeeffect.rdlc';

    Caption = 'Trade Effect';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    dataset
    {
        dataitem("Payment Line"; "Payment Line")
        {
            CalcFields = "WithHold Tax Amount";
            DataItemTableView = SORTING("No.", "Line No.");
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; RecCompany.Name)
            {
            }
            column(Address; RecCompany.Address)
            {
            }
            column(Address2; RecCompany."Address 2")
            {
            }
            column(City; RecCompany.City)
            {
            }
            column(RIB; RIB)
            {
            }
            column(NumBorderau; NumBorderau)
            {
            }
            column(RecCompany_Picture; RecCompany.Picture)
            {
            }
            column(Siege; Siege)
            {
            }
            column(CP; CP)
            {
            }
            column(RecBankAccount_Picture; RecBankAccount.Picture)
            {
            }
            column(Nom_Control1000000003; Nom)
            {
            }
            column("Payment_Line__N__Chèque_"; "Payment Title No.")
            {
            }
            column(Payment_Line__Header_Account_No__; "Payment Title Bank Account")
            {
            }
            column("Payment_Line_Libellé"; "Drawee Reference")
            {
            }
            column(Payment_Line__Payment_Line___Credit_Amount_; "Payment Line"."Credit Amount")
            {
            }
            column(FORMAT__Line_No___10000_0_; FORMAT("Line No." / 10000, 0))
            {
            }
            column(Payment_Line__Account_No__; "Account No.")
            {
            }
            column(DueDate; "Payment Line"."Due Date")
            {
            }
            column(Payment_Line__Payment_Line___Credit_Amount__Control1000000023; "Payment Line"."Credit Amount")
            {
            }
            column(Nbr; Nbr)
            {
            }
            column(Montant; Montant)
            {
            }
            column(MontantLettre; MontantLettre)
            {
            }
            column(Payment_LineCaption; Payment_LineCaptionLbl)
            {
            }
            column(N_Caption; N_CaptionLbl)
            {
            }
            column(Nom_de_la_banque__________Caption; Nom_de_la_banque__________CaptionLbl)
            {
            }
            column(Nom_Raison_Social_du_Client___Caption; Nom_Raison_Social_du_Client___CaptionLbl)
            {
            }
            column(RIB___________Caption; RIB___________CaptionLbl)
            {
            }
            column(Date__Caption; Date__CaptionLbl)
            {
            }
            column("Siège__Caption"; Siège__CaptionLbl)
            {
            }
            column(N__CHEQUECaption; N__CHEQUECaptionLbl)
            {
            }
            column(BANQUECaption; BANQUECaptionLbl)
            {
            }
            column(NOM_DU_TIREURCaption; NOM_DU_TIREURCaptionLbl)
            {
            }
            column(MONTANTCaption; MONTANTCaptionLbl)
            {
            }
            column(N____Caption; N____CaptionLbl)
            {
            }
            column(CODECaption; CODECaptionLbl)
            {
            }
            column(Total_Remise__en_toutes_lettres____Caption; Total_Remise__en_toutes_lettres____CaptionLbl)
            {
            }
            column("Nombre_chèquesCaption"; Nombre_chèquesCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Payment_Line_No_; "No.")
            {
            }
            column(Payment_Line_Line_No_; "Line No.")
            {
            }
            column(Cachet_et_signature_du_clientCaption; Cachet_et_signature_du_clientCaptionLbl)
            {
            }
            column(Cachet_et_visa_de_la_banqueCaption; Cachet_et_visa_de_la_banqueCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Payment_Line_CreatedfromNo; "Payment Line"."Created from No.")
            {
            }
            column(DebitAmount_PaymentLine2; "Payment Line"."Debit Amount" - "Payment Line"."WithHold Tax Amount")
            {
            }
            column(AmountPrinted; AmountPrinted)
            {
            }
            column(BankAccountNo; RecBankAccount."No.")
            {
            }
            column(BankAccountName; RecBankAccount.Name)
            {
            }
            column(PostDate; PostDate)
            {
            }
            column(Contact; Contact)
            {
            }
            column(TotalAmountLCY; TotalAmountLCY)
            {
            }
            column(VendAddress; VendAddress)
            {
            }
            column(RIB2; RIB2)
            {
            }
            column(BankName; Namebank)
            {
            }
            column(VendorName_G; VendorName_G)
            {
            }
            column(BankAccountNo_PaymentLine; "Payment Line"."Bank Account No.")
            {
            }
            column(BankAccountName_PaymentLine; "Payment Line"."Bank Account Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF RecHeaderPayment.GET("Payment Line"."No.") THEN;

                PostDate := RecHeaderPayment."Posting Date";
                RecHeaderPayment.CALCFIELDS("Amount (LCY)");
                //ADI-->>
                IF VendorBAnkAccount.GET("Payment Line"."Account No.", "Payment Line"."Bank Account Code") THEN BEGIN
                    VendorName_G := Vendor.Name;
                    EVALUATE(Rkey2, FORMAT(VendorBAnkAccount."RIB Key"));
                    RIB2 := VendorBAnkAccount."Bank Branch No." + VendorBAnkAccount."Agency Code" +
                    VendorBAnkAccount."Bank Account No." + Rkey2;
                    Namebank := VendorBAnkAccount.Name;
                    IF VendorBAnkAccount.IBAN <> '' THEN
                        RIB2 := VendorBAnkAccount.IBAN;
                    SWIFT := VendorBAnkAccount."SWIFT Code";
                END;
                VendAddress := VendorBAnkAccount.Address + ' ' + VendorBAnkAccount.City;
                //ADI<<--
                TotalAmountLCY := RecHeaderPayment."Amount (LCY)";


                IF RecBankAccount.GET(RecHeaderPayment."Account No.") THEN;

                EVALUATE(Rkey, FORMAT(RecBankAccount."RIB Key"));
                RIB := RecBankAccount."Bank Branch No." + RecBankAccount."Agency Code" +
                RecBankAccount."Bank Account No." + Rkey;
                NumBorderau := "Payment Line"."No.";
                RecBankAccount.CALCFIELDS(RecBankAccount.Picture);
                Contact := RecBankAccount.Contact;
                Adresse := RecBankAccount.Address + '  ' + RecBankAccount.City + ' ' + RecBankAccount."Post Code";
                RecPaymentLine.SETFILTER(RecPaymentLine."No.", NumBorderau);
                Nbr += 1;
                RecCompany.GET();
                RecCompany.CALCFIELDS(RecCompany.Picture);
                Siege := ' ';
                Siege := RecCompany.Address + RecCompany.City + ' ' + RecCompany."Post Code";

                //CurrReport.SHOWOUTPUT :=
                //CurrReport.TOTALSCAUSEDBY = "Payment Line".FIELDNO("No.");

                CALCFIELDS("Payment Line"."WithHold Tax Amount");
                AmountPrinted := ABS("Payment Line"."Credit Amount") - ABS("Payment Line"."WithHold Tax Amount");
                Montant := '#' + FORMAT(AmountPrinted) + '#';



                Check_G.InitTextVariable;

                Check_G.FormatNoText(NoText_G, AmountPrinted, '');

                MontantLettre := NoText_G[1];
            end;

            trigger OnPreDataItem()
            begin
                RecCompany.GET;
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                //CurrReport.CREATETOTALS("Payment Line"."Credit Amount");
                IF ISSERVICETIER THEN
                    RecordCounter := 0;


                Nbr := 0;
                LastFieldNo := FIELDNO("No.");
                AmountPrinted := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        Effet_Cap = 'Trade Effect';
        TraiteNo_Cap = 'Deals No.';
        FactureNo_cap = 'Invoice No';
        Abid_Cap = 'Abidjan';
        Au_Cap = 'To';
        BPF_Cap = 'B.P.F';
        FCFA_Cap = 'FCFA';
        Text001 = 'Please pay against this bill of exchange';
        Alordre_Cap = 'At the command of';
        Somme_Cap = 'The sum of';
        FrancsCFA_Cap = 'Francs CFA';
        Titre_Cap = 'Title';
        Accep_Cap = 'Acceptance or Downline';
        Timbre_Cap = 'Stamp';
        Domiciliation_Cap = 'DOMICILIATION';
        Pieddepage1 = 'Marcory Boulevard VGE, SERHAN S.C.I. Building, 7th Floor';
        Pieddepage2 = '01BP 4502 Abidjan 01';
        Pieddepage3 = 'CI-ABJ-2014-B-22099';
    }

    var
        VendorBAnkAccount: Record "Vendor Bank Account";
        RecHeaderPayment: Record "Payment Header";
        RecPaymentLine: Record "Payment Line";
        RecCompany: Record "Company Information";
        RecBankAccount: Record "Bank Account";
        Vendor: Record Vendor;
        Check_G: Report Check;
        LastFieldNo: Integer;


        PrintOnlyOnePerPage: Boolean;

        AmountPrinted: Decimal;

        RecordCounter: Integer;


        Nom: Text[30];
        RIB: Code[50];

        NumBorderau: Code[20];
        Nbr: Integer;

        Adresse: Text[100];
        Siege: Text[100];
        CP: Text[50];
        Rkey: Text[2];
        MontantLettre: Text[1024];
        Payment_LineCaptionLbl: Label 'BORDEREAU REMISE CHEQUES';
        N_CaptionLbl: Label 'N° Bordereau';
        Nom_de_la_banque__________CaptionLbl: Label 'Nom de la banque :        ';
        Nom_Raison_Social_du_Client___CaptionLbl: Label 'Nom/Raison Social du Client : ';
        RIB___________CaptionLbl: Label 'RIB :         ';
        Date__CaptionLbl: Label 'Date :';
        "Siège__CaptionLbl": Label 'Siège: ';
        N__CHEQUECaptionLbl: Label 'N° CHEQUE';
        BANQUECaptionLbl: Label 'BANQUE';
        NOM_DU_TIREURCaptionLbl: Label 'NOM DU TIREUR';
        MONTANTCaptionLbl: Label 'MONTANT';
        N____CaptionLbl: Label 'N°   ';
        CODECaptionLbl: Label 'CODE';
        Total_Remise__en_toutes_lettres____CaptionLbl: Label 'Total Remise (en toutes lettres) : ';
        "Nombre_chèquesCaptionLbl": Label 'Nombre chèques';
        TotalCaptionLbl: Label 'Total';
        Cachet_et_signature_du_clientCaptionLbl: Label 'Cachet et signature du client';
        Cachet_et_visa_de_la_banqueCaptionLbl: Label 'Cachet et visa de la banque';
        DateCaptionLbl: Label 'Date';
        Contact: Text;
        PostDate: Date;
        TotalAmountLCY: Decimal;

        RIB2: Code[50];
        Namebank: Text;
        Rkey2: Text[2];
        SWIFT: Text;


        VendAddress: Text[50];
        Montant: Text[100];


        NoText_G: array[10] of Text;
        VendorName_G: Text[100];
}

