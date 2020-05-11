pageextension 84002 "TRANSPpageext84002Sl&RcvSt" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Direct Debit Mandate Nos.")
        {
            field("Tour Nos."; "Tour Nos.")
            {
                ApplicationArea = all;
            }
        }
    }
}

