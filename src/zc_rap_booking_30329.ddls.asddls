
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true

define view entity ZC_RAP_BOOKING_30329 as projection on ZI_RAP_BOOKING_30329 as booking
{
key BookingUUID,
       TravelUUID,
       @Search.defaultSearchElement: true
       BookingID,
       BookingDate,
       @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Customer', element: 'CustomerID'  } }]
       @ObjectModel.text.element: ['CustomerName']
       @Search.defaultSearchElement: true
       CustomerID,
       _Customer.LastName as CustomerName,
       @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Carrier', element: 'AirlineID' }}]
       @ObjectModel.text.element: ['CarrierName']
       CarrierID,
       _Carrier.Name      as CarrierName,
       @Consumption.valueHelpDefinition: [ {entity: {name: '/DMO/I_Flight', element: 'ConnectionID'},
                                            additionalBinding: [ { localElement: 'CarrierID',    element: 'AirlineID' },
                                                                 { localElement: 'FlightDate',   element: 'FlightDate',   usage: #RESULT},
                                                                 { localElement: 'FlightPrice',  element: 'Price',        usage: #RESULT },
                                                                 { localElement: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT } ] } ]
       ConnectionID,
       FlightDate,
       @Semantics.amount.currencyCode: 'CurrencyCode'
       FlightPrice,
       @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
       CurrencyCode,
       LocalLastChangedAt,

       /* associations */
       _Travel : redirected to parent ZC_RAP_TRAVEL_30329,
       _Customer,
       _Carrier,
       _Connection,
       _Flight
       
       /*
       The alias Booking is specified for the projected view
The view annotations @Metadata.allowedExtension is specified before the DEFINE statement to allow the projection view to be enhanced with separate metadata extensions
The view annotations @Search.Searchable is specified before the DEFINE statement to allow the projection view to enable the full-text (aka freestyle) search.
The view columns BookingID and CustomerID are enabled for freestyle search.
The view elements CustomerName and CarrierName from the associations _Customer_ and _Carrier respectively have been added to the projection list.
They are specified as textual description for the view elements CustomerID and CarrierID respectively using the annotation @ObjectModel.text.element.
Value helps are specified for the view elements CustomerID, CarrierID, ConnectionID and CurrencyCode using the annotation @Consumption.valueHelpDefinition.
In the value help definition of the element ConnectionID, an additional binding condition is defined for returning values from the selected value help record for the local view elements CarrierID, FlightDate, FlightPrice and Currency.
The view element CurrencyCode is specified as reference field for the currency field FlightPrice.
The view elements CreatedBy and LastChangedBy have been removed from the projection list because they only have an administrative function and will be of no use in our scenario. The view element LocalLastChangedAt remains in the projection list because it will be used for the transactional enablement of Your Travel List Report App in week 3 – especially for the implementation of the optimistic lock.
All associations have been exposed in the projection list.
The association to the travel BO parent node has been redirected to the appropriate Travel BO projection view using the redirected to parent statement.

*/
 }
