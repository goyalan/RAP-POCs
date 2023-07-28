/*@AbapCatalog.viewEnhancementCategory: [#NONE] */
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'TRAVEL BO VIEW'
/*@Metadata.ignorePropagatedAnnotations: true 
@ObjectModel.usageType:{
    serviceQuality: #X , 
    sizeCategory: #S,
    dataClass: #MIXED
}*/
define root view entity ZI_RAP_TRAVEL_30329 as select from zrap_atrav_30329 as travel

/*association [0..*] to ZI_RAP_BOOKING_30329 as _Booking on $projection.TravelUUID = _Booking.TravelUUID */ /*associations are target side cardinality*/
composition [0..*] of ZI_RAP_BOOKING_30329 as _Booking /*for transactional app */
association [0..1] to /DMO/I_Agency       as _Agency on $projection.AgencyID = _Agency.AgencyID
association [0..1] to /DMO/I_Customer  as _customer on $projection.CustomerID =_customer.CustomerID
association [0..1] to I_Currency as _Currency on $projection.CurrencyCode = _Currency.Currency 

{
   key travel_uuid           as TravelUUID,
       travel_id             as TravelID,
       agency_id             as AgencyID,
       customer_id           as CustomerID,
       begin_date            as BeginDate,
       end_date              as EndDate,
       @Semantics.amount.currencyCode: 'CurrencyCode'
       booking_fee           as BookingFee,
       @Semantics.amount.currencyCode: 'CurrencyCode'
       total_price           as TotalPrice,
       currency_code         as CurrencyCode,
       description           as Description,
       overall_status        as TravelStatus,
       @Semantics.user.createdBy: true 
       created_by            as CreatedBy,   /*syatem variebles for consumtion / trasactional apps */
       @Semantics.systemDateTime.createdAt: true /*syatem variebles for consumtion / trasactional apps */
       created_at            as CreatedAt,
       @Semantics.user.lastChangedBy: true  /*syatem variebles for consumtion / trasactional apps */
       last_changed_by       as LastChangedBy,
       @Semantics.systemDateTime.lastChangedAt: true  /*syatem variebles for consumtion / trasactional apps */
       last_changed_at       as LastChangedAt,
       @Semantics.systemDateTime.localInstanceLastChangedAt: true  /*syatem variebles for consumtion / trasactional apps */
       local_last_changed_at as LocalLastChangedAt,
       /*
       To ensure uniform data processing on the consumer side, @Semantics annotations are used to enrich some of the fields – i.e. the currency fields and the administrative fields in the present scenario.
The currency key field CurrencyCode is specified as the reference field of the currency fields BookingFee and TotalPrice using the annotation @Semantics.amount.currencyCode.
The annotation of the administrative data is a preparation step for week 3, where the transactional behavior of the Travel List Report app will be enabled. These annotations are required to allow the automatic update of the fields on every operation.
      /*
       
       /*assosciations */
       _Booking ,
       _Agency ,
       _customer ,
       _Currency 
       
       
}
