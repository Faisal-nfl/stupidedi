# frozen_string_literal: true
module Stupidedi
  module TransactionSets
    module FiftyTen
      module Implementations
        module X212
          b = Builder
          d = Schema
          r = SegmentReqs
          e = ElementReqs
          s = SegmentDefs

          HR276 = b.build("HR", "276", "Health Care Claim Request",
            d::TableDef.header("Table 1 - Header",
              b::Segment(100, s::ST, "Transaction Set Header",
                r::Required, d::RepeatCount.bounded(1),
                b::Element(e::Required,    "Transaction Set Identifier Code", b::Values("276")),
                b::Element(e::Required,    "Transaction Set Control Number"),
                b::Element(e::Required,    "Version, Release, or Industry Identifier", b::Values("005010X212"))),
              b::Segment(200, s::BHT, "Beginning of Hierarchical Transaction",
                r::Required, d::RepeatCount.bounded(1),
                b::Element(e::Required,    "Hierarchical Structure Code", b::Values("0010")),
                b::Element(e::Required,    "Transaction Set Purpose Code", b::Values("13")),
                b::Element(e::Required,    "Reference Identification"),
                b::Element(e::Required,    "Transaction Set Creation Date"),
                b::Element(e::Required,    "Transaction Set Creation Time"),
                b::Element(e::NotUsed,     "Transaction Type Code"))),

            d::TableDef.detail("Table 2 - Information Source Detail",
              d::LoopDef.build("2000A INFORMATION SOURCE LEVEL",
                d::RepeatCount.bounded(1),
                b::Segment(100, s::HL, "Information Source Level",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Hierarchical ID Number"),
                  b::Element(e::NotUsed,     "Hierarchical Parent ID Number"),
                  b::Element(e::Required,    "Hierarchical Level Code", b::Values("20")),
                  b::Element(e::Required,    "Hierachical Child Code", b::Values("1"))),

                d::LoopDef.build("2100A PAYER NAME",
                  d::RepeatCount.bounded(1),
                  b::Segment(500, s::NM1, "Payer Name",
                    r::Required, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Entity Identifier Code", b::Values("PR")),
                    b::Element(e::Required,    "Entity Type Qualifier", b::Values("2")),
                    b::Element(e::Required,    "Payer Name"),
                    b::Element(e::NotUsed,     "Name First"),
                    b::Element(e::NotUsed,     "Name Middle"),
                    b::Element(e::NotUsed,     "Name Prefix"),
                    b::Element(e::NotUsed,     "Name Suffix"),
                    b::Element(e::Required,    "Identification Code Qualifier", b::Values("PI", "XV")),
                    b::Element(e::Required,    "Payer Identifier"),
                    b::Element(e::NotUsed,     "Entity Relationship Code"),
                    b::Element(e::NotUsed,     "Entity Identifier Code"),
                    b::Element(e::NotUsed,     "Name Last or Organization Name"))))),

            d::TableDef.detail("Table 2 - Information Receiver Detail",
              d::LoopDef.build("2000B INFORMATION RECEIVER LEVEL",
                d::RepeatCount.bounded(1),
                b::Segment(100, s::HL, "Information Receiver Level",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Hierarchical ID Number"),
                  b::Element(e::Required,    "Hierarchical Parent ID Number"),
                  b::Element(e::Required,    "Hierarchical Level Code", b::Values("21")),
                  b::Element(e::Required,    "Hierachical Child Code", b::Values("1"))),

              d::LoopDef.build("2100B INFORMATION RECEIVER NAME",
                d::RepeatCount.bounded(1),
                b::Segment(500, s::NM1, "Information Receiver Name",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Entity Identifier Code", b::Values("41")),
                  b::Element(e::Required,    "Entity Type Qualifier", b::Values("1", "2")),
                  b::Element(e::Situational, "Information Receiver Last or Organization Name"),
                  b::Element(e::Situational, "Information Receiver First Name"),
                  b::Element(e::Situational, "Information Receiver Middle Name"),
                  b::Element(e::NotUsed,     "Name Prefix"),
                  b::Element(e::NotUsed,     "Name Suffix"),
                  b::Element(e::Required,    "Identification Code Qualifier", b::Values("46")),
                  b::Element(e::Required,    "Information Receiver Identification Number"),
                  b::Element(e::NotUsed,     "Entity Relationship Code"),
                  b::Element(e::NotUsed,     "Entity Identifier Code"),
                  b::Element(e::NotUsed,     "Name Last or Organization Name"))))),

            d::TableDef.detail("Table 2 - Service Provider Detail",
              d::LoopDef.build("2000C SERVICE PROVIDER LEVEL",
                d::RepeatCount.bounded(1),
                b::Segment(100, s::HL, "Billing Provider of Service Level",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Hierarchical ID Number"),
                  b::Element(e::Required,    "Hierarchical Parent ID Number"),
                  b::Element(e::Required,    "Hierarchical Level Code", b::Values("19")),
                  b::Element(e::Required,    "Hierachical Child Code", b::Values("1"))),

                d::LoopDef.build("2100C PROVIDER NAME",
                  d::RepeatCount.bounded(2),
                  b::Segment(500, s::NM1, "Billing Provider Name",
                    r::Required, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Entity Identifier Code", b::Values("1P")),
                    b::Element(e::Required,    "Entity Type Qualifier", b::Values("1", "2")),
                    b::Element(e::Situational, "Provider Last or Organization Name"),
                    b::Element(e::Situational, "Provider First Name"),
                    b::Element(e::Situational, "Provider Middle Name"),
                    b::Element(e::NotUsed,     "Name Prefix"),
                    b::Element(e::Situational, "Provider Name Suffix"),
                    b::Element(e::Required,    "Identification Code Qualifier", b::Values("FI", "SV", "XX")),
                    b::Element(e::Required,    "Provider Identifier"),
                    b::Element(e::NotUsed,     "Entity Relationship Code"),
                    b::Element(e::NotUsed,     "Entity Identifier Code"),
                    b::Element(e::NotUsed,     "Name Last or Organization Name"))))),

            d::TableDef.detail("Table 2 - Subscriber Detail",
              d::LoopDef.build("2000D SUBSCRIBER LEVEL",
                d::RepeatCount.bounded(1),
                b::Segment(100, s::HL, "Subscriber Level",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Hierarchical ID Number"),
                  b::Element(e::Required,    "Hierarchical Parent ID Number"),
                  b::Element(e::Required,    "Hierarchical Level Code", b::Values("22")),
                  b::Element(e::Required,    "Hierachical Child Code", b::Values("0", "1"))),

                b::Segment(400, s::DMG, "Subscriber Demographic Information",
                  r::Situational, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Date Time Period Format Qualifier", b::Values("D8")),
                  b::Element(e::Required,    "Subscriber Birth Date"),
                  b::Element(e::Situational, "Subscriber Gender Code", b::Values("F", "M")),
                  b::Element(e::NotUsed,     "Marital Status Code"),
                  b::Element(e::NotUsed,     "COMPOSITE RACE OR ETHNICITY INFORMATION"),
                  b::Element(e::NotUsed,     "Citizenship Status Code"),
                  b::Element(e::NotUsed,     "Country Code"),
                  b::Element(e::NotUsed,     "Basis of Verification Code"),
                  b::Element(e::NotUsed,     "Quantity"),
                  b::Element(e::NotUsed,     "Code LIst Qualifier Code"),
                  b::Element(e::NotUsed,     "Industry Code")),

                d::LoopDef.build("2100D SUBSCRIBER NAME",
                  d::RepeatCount.bounded(1),
                  b::Segment(500, s::NM1, "Subscriber Name",
                    r::Required, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Entity Identifier Code", b::Values("IL")),
                    b::Element(e::Required,    "Entity Type Qualifier", b::Values("1", "2")),
                    b::Element(e::Required,    "Subscriber Last Name"),
                    b::Element(e::Situational, "Subscriber First Name",),
                    b::Element(e::Situational, "Subscriber Middle Name or Initial"),
                    b::Element(e::NotUsed,     "Name Prefix"),
                    b::Element(e::Situational, "Subscriber Name Suffix"),
                    b::Element(e::Required,    "Identification Code Qualifier", b::Values("24", "II", "MI")),
                    b::Element(e::Required,    "Subscriber Identifier"),
                    b::Element(e::NotUsed,     "Entity Relationship Code"),
                    b::Element(e::NotUsed,     "Entity Identifier Code"),
                    b::Element(e::NotUsed,     "Name Last or Organization Name"))),

                d::LoopDef.build("2200D CLAIM STATUS TRACKING NUMBER",
                  d::RepeatCount.unbounded,
                  b::Segment( 900, s::TRN, "Claim Status Tracking Number",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Trace Type Code", b::Values("1")),
                    b::Element(e::Required,    "Current Transaction Trace Number"),
                    b::Element(e::NotUsed,     "Originating Company Identifier"),
                    b::Element(e::NotUsed,     "Reference Identification")),
                  b::Segment(1000, s::REF, "Payer Claim Control Number",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("1K")),
                    b::Element(e::Required,    "Payer Claim Control Number"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1000, s::REF, "Institutional Bill Type Identification",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("BLT")),
                    b::Element(e::Required,    "Bill Type Identifier"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1000, s::REF, "Application or Location System Identifier",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("LU")),
                    b::Element(e::Required,    "Application or Location System Identifier"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1000, s::REF, "Group Number",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("6P")),
                    b::Element(e::Required,    "Group Number"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1000, s::REF, "Patient Control Number",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("EJ")),
                    b::Element(e::Required,    "Patient Control Number"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1000, s::REF, "Pharmacy Prescription Number",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("XZ")),
                    b::Element(e::Required,    "Pharmacy Prescription Number"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1000, s::REF, "Claim Identification Number for Clearinghouses and Other Transmission Intermediaries",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("D9")),
                    b::Element(e::Required,    "Clearinghouse Trace Number"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1100, s::AMT, "Institutional Bill Type Identification",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Amount Qualifier Code", b::Values("T3")),
                    b::Element(e::Required,    "Total Claim Charge Amount"),
                    b::Element(e::NotUsed,     "Credit/Debit Flag Code")),
                  b::Segment(1200, s::DTP, "Claim Level Service Date",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Date Time Qualifier", b::Values("472")),
                    b::Element(e::Required,    "Date Time Period Format Qualifier", b::Values("D8", "RD8")),
                    b::Element(e::Required,    "Claim Service Period")),
                  d::LoopDef.build("2210D SERVICE LINE INFORMATION",
                    d::RepeatCount.unbounded,
                    b::Segment(1300, s::SVC, "Service Line Information",
                      r::Situational, d::RepeatCount.bounded(1),
                      b::Element(e::Required,    "COMPOSITE MEDICAL PROCEDURE IDENTIFIER",
                        b::Element(e::Required,    "Product or Service ID Qualifier", b::Values("AD", "ER", "HC", "HP", "IV", "N4", "NU", "WK")),
                        b::Element(e::Required,    "Procedure Code"),
                        b::Element(e::Situational, "Procedure Modifier"),
                        b::Element(e::Situational, "Procedure Modifier"),
                        b::Element(e::Situational, "Procedure Modifier"),
                        b::Element(e::Situational, "Procedure Modifier"),
                        b::Element(e::NotUsed,     "Description"),
                        b::Element(e::NotUsed,     "Product/Service ID")),
                      b::Element(e::Required,    "Line Item Charge Amount"),
                      b::Element(e::NotUsed,     "Monetary Amount"),
                      b::Element(e::Situational, "Revenue Code"),
                      b::Element(e::NotUsed,     "Quantity"),
                      b::Element(e::NotUsed,     "COMPOSITE MEDICAL PROCEDURE IDENTIFIER"),
                      b::Element(e::Situational, "Units of Service Count")),
                    b::Segment(1400, s::REF, "Service Line Item Identification",
                      r::Situational, d::RepeatCount.bounded(1),
                      b::Element(e::Required,    "Reference Identification Qualifier", b::Values("FJ")),
                      b::Element(e::Required,    "Line Item Control Number"),
                      b::Element(e::NotUsed,     "Description"),
                      b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                    b::Segment(1500, s::DTP, "Service Line Date",
                      r::Required, d::RepeatCount.bounded(1),
                      b::Element(e::Required,    "Date Time Qualifier", b::Values("472")),
                      b::Element(e::Required,    "Date Time Period Format Qualifier", b::Values("D8", "RD8")),
                      b::Element(e::Required,    "Service Line Date")))))),

            d::TableDef.detail("Table 2 - Dependent Detail",
              d::LoopDef.build("2000E DEPENDENT LEVEL",
                d::RepeatCount.bounded(1),
                b::Segment(100, s::HL, "Dependent Level",
                  r::Situational, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Hierarchical ID Number"),
                  b::Element(e::Required,    "Hierarchical Parent ID Number"),
                  b::Element(e::Required,    "Hierarchical Level Code", b::Values("23")),
                  b::Element(e::NotUsed,     "Hierachical Child Code")),
                b::Segment(400, s::DMG, "Dependent Demographic Information",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Date Time Period Format Qualifier", b::Values("D8")),
                  b::Element(e::Required,    "Patient Birth Date"),
                  b::Element(e::Situational, "Patient Gender Code", b::Values("F", "M")),
                  b::Element(e::NotUsed,     "Marital Status Code"),
                  b::Element(e::NotUsed,     "COMPOSITE RACE OR ETHNICITY INFORMATION"),
                  b::Element(e::NotUsed,     "Citizenship Status Code"),
                  b::Element(e::NotUsed,     "Country Code"),
                  b::Element(e::NotUsed,     "Basis of Verification Code"),
                  b::Element(e::NotUsed,     "Quantity"),
                  b::Element(e::NotUsed,     "Code LIst Qualifier Code"),
                  b::Element(e::NotUsed,     "Industry Code"))),

                d::LoopDef.build("2100E DEPENDENT NAME",
                  d::RepeatCount.bounded(1),
                  b::Segment(500, s::NM1, "Dependent Name",
                    r::Required, d::RepeatCount.bounded(1),
                      b::Element(e::Required,    "Entity Identifier Code", b::Values("QC")),
                      b::Element(e::Required,    "Entity Type Qualifier", b::Values("1")),
                      b::Element(e::Required,    "Patient Last Name"),
                      b::Element(e::Situational, "Patient First Name"),
                      b::Element(e::Situational, "Patient Middle Name or Initial"),
                      b::Element(e::NotUsed,     "Name Prefix"),
                      b::Element(e::Situational, "Patient Name Suffix"),
                      b::Element(e::NotUsed,     "Identification Code Qualifier"),
                      b::Element(e::NotUsed,     "Identification Code"),
                      b::Element(e::NotUsed,     "Entity Relationship Code"),
                      b::Element(e::NotUsed,     "Entity Identifier Code"),
                      b::Element(e::NotUsed,     "Name Last or Organization Name"))),

                d::LoopDef.build("2200E CLAIM STATUS TRACKING NUMBER",
                  d::RepeatCount.unbounded,
                  b::Segment( 900, s::TRN, "Claim Status Tracking Number",
                      r::Required, d::RepeatCount.bounded(1),
                      b::Element(e::Required,    "Trace Type Code", b::Values("1")),
                      b::Element(e::Required,    "Current Transaction Trace Number"),
                      b::Element(e::NotUsed,     "Originating Company Identifier"),
                      b::Element(e::NotUsed,     "Reference Identification")),
                  b::Segment(1000, s::REF, "Payer Claim Control Number",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("1K")),
                    b::Element(e::Required,    "Payer Claim Control Number"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1000, s::REF, "Institutional Bill Type Identification",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("BLT")),
                    b::Element(e::Required,    "Bill Type Identifier"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1000, s::REF, "Application or Location System Identifier",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("LU")),
                    b::Element(e::Required,    "Application or Location System Identifier"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1000, s::REF, "Group Number",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("6P")),
                    b::Element(e::Required,    "Group Number"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1000, s::REF, "Patient Control Number",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("EJ")),
                    b::Element(e::Required,    "Patient Control Number"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1000, s::REF, "Pharmacy Prescription Number",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("XZ")),
                    b::Element(e::Required,    "Pharmacy Prescription Number"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1000, s::REF, "Claim Identification Number for Clearinghouses and Other Transmission Intermediaries",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("D9")),
                    b::Element(e::Required,    "Clearinghouse Trace Number"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(1100, s::AMT, "Claim Submitted Charges",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Amount Qualifier Code", b::Values("T3")),
                    b::Element(e::Required,    "Total Claim Charge Amount"),
                    b::Element(e::NotUsed,     "Credit/Debit Flag Code")),
                  b::Segment(1200, s::DTP, "Claim Service Date",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Date Time Qualifier", b::Values("472")),
                    b::Element(e::Required,    "Date Time Period Format Qualifier", b::Values("D8", "RD8")),
                    b::Element(e::Required,    "Claim Service Period")),
                  d::LoopDef.build("2210E SERVICE LINE INFORMATION",
                    d::RepeatCount.unbounded,
                    b::Segment(1300, s::SVC, "Service Line Information",
                        r::Situational, d::RepeatCount.bounded(1),
                        b::Element(e::Required,    "COMPOSITE MEDICAL PROCEDURE IDENTIFIER",
                          b::Element(e::Required,    "Product or Service ID Qualifier", b::Values("AD", "ER", "HC", "HP", "IV", "N4", "NU", "WK")),
                          b::Element(e::Required,    "Procedure Code"),
                          b::Element(e::Situational, "Procedure Modifier"),
                          b::Element(e::Situational, "Procedure Modifier"),
                          b::Element(e::Situational, "Procedure Modifier"),
                          b::Element(e::Situational, "Procedure Modifier"),
                          b::Element(e::NotUsed,     "Description"),
                          b::Element(e::NotUsed,     "Product/Service ID")),
                        b::Element(e::Required,    "Line Item Charge Amount"),
                        b::Element(e::NotUsed,     "Monetary Amount"),
                        b::Element(e::Situational, "Revenue Code"),
                        b::Element(e::NotUsed,     "Quantity"),
                        b::Element(e::NotUsed,     "COMPOSITE MEDICAL PROCEDURE IDENTIFIER"),
                        b::Element(e::Situational, "Units of Service Count")),
                      b::Segment(1400, s::REF, "Service Line Item Identification",
                        r::Situational, d::RepeatCount.bounded(1),
                        b::Element(e::Required,    "Reference Identification Qualifier", b::Values("FJ")),
                        b::Element(e::Required,    "Line Item Control Number"),
                        b::Element(e::NotUsed,     "Description"),
                        b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                      b::Segment(1500, s::DTP, "Service Line Date",
                        r::Required, d::RepeatCount.bounded(1),
                        b::Element(e::Required,    "Date Time Qualifier", b::Values("472")),
                        b::Element(e::Required,    "Date Time Period Format Qualifier", b::Values("D8", "RD8")),
                        b::Element(e::Required,    "Service Line Date"))))),
            d::TableDef.detail("Table 3 - Summary",
              b::Segment(1600, s::SE, "Transaction Set Trailer",
                r::Required, d::RepeatCount.bounded(1),
                b::Element(e::Required,    "Transaction Segment Count"),
                b::Element(e::Required,    "Transaction Set Control Number"))))

        end
      end
    end
  end
end
