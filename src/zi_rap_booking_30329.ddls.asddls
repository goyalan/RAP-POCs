
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'BOOK BO'

define view entity ZI_RAP_BOOKING_30329 as select from zrap_abook_30329 as booking

  /*  association [1..1] to ZI_RAP_TRAVEL_30329        as _Travel     on  $projection.TravelUUID = _Travel.TravelUUID */
    association to parent ZI_RAP_TRAVEL_30329        as _Travel     on  $projection.TravelUUID = _Travel.TravelUUID 
   
   association [1..1] to /DMO/I_Customer           as _Customer   on  $projection.CustomerID   = _Customer.CustomerID
   association [1..1] to /DMO/I_Carrier            as _Carrier    on  $projection.CarrierID    = _Carrier.AirlineID
   association [1..1] to /DMO/I_Connection         as _Connection on  $projection.CarrierID    = _Connection.AirlineID
                                                                  and $projection.ConnectionID = _Connection.ConnectionID
   association [1..1] to /DMO/I_Flight             as _Flight     on  $projection.CarrierID    = _Flight.AirlineID
                                                                  and $projection.ConnectionID = _Flight.ConnectionID
                                                                  and $projection.FlightDate   = _Flight.FlightDate
   association [0..1] to I_Currency                as _Currency   on $projection.CurrencyCode    = _Currency.Currency    
 {
   key booking_uuid          as BookingUUID,
       travel_uuid           as TravelUUID,
       booking_id            as BookingID,
       booking_date          as BookingDate,
       customer_id           as CustomerID,
       carrier_id            as CarrierID,
       connection_id         as ConnectionID,
       flight_date           as FlightDate,
       @Semantics.amount.currencyCode: 'CurrencyCode'
       flight_price          as FlightPrice,
       currency_code         as CurrencyCode,
       @Semantics.user.createdBy: true
       created_by            as CreatedBy,
       @Semantics.user.lastChangedBy: true
       last_changed_by       as LastChangedBy,
       @Semantics.systemDateTime.localInstanceLastChangedAt: true
       local_last_changed_at as LocalLastChangedAt,

       /* associations */
      _Travel,
       _Customer,
       _Carrier,
       _Connection,
       _Flight,
       _Currency
 
 /*
 Both CDS views are now activated, but warnings are displayed in the Problems view and in the editor. The reason behind this is that the authority check is allowed for these CDS views (@AccessControl.authorizationCheck: #CHECK), but no CDS access control is currently defined for them. You will work on this in unit 7 of week 2 where you will define a basic CDS access control.
 */
}
