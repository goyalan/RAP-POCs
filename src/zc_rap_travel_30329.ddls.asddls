@EndUserText.label: 'TRAVEL CD DATA MODEL PROJECTION VIEW'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true

define root view entity ZC_RAP_TRAVEL_30329 as projection on ZI_RAP_TRAVEL_30329 as Travel
{
    key TravelUUID,
    
    @Search.defaultSearchElement: true
    TravelID,
    @Consumption.valueHelpDefinition: [{ entity : { name : '/DMO/I_Agency', element: 'AgencyID' } } ]
    @ObjectModel.text.element: ['AgencyName']
    @Search.defaultSearchElement: true
    AgencyID,
    _Agency.Name as AgencyName , 
    @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Customer', element: 'CustomerID'} }]
       @ObjectModel.text.element: ['CustomerName'] /*Within the context of CDS views, the text elements establish the link between identifier elements (code values) of the view and its descriptive language-independent texts. For example, you can define a link between a company code and the (descriptive) company name, or between currency code and the currency name. These kinds of descriptive texts are language-independent.*/
       @Search.defaultSearchElement: true
    CustomerID,
     _customer.LastName as CustomerName,
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Currency', element: 'Currency'} }]
    CurrencyCode,
    Description,
    TravelStatus,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Agency,
    _Booking : redirected to composition child ZC_RAP_BOOKING_30329 ,
    _Currency,
    _customer
    
    /*Short explanation: What has changed?

The alias Travel is specified for the projected view
The keyword root is specified in the DEFINE statement to specify the projected Travel BO as root node.
The view annotations @Metadata.allowedExtension is specified before the DEFINE statement to allow the projection view to be enhanced with separate metadata extensions
The view annotations @Search.Searchable is specified before the DEFINE statement to allow the projection view to enable the full-text (aka freestyle) search.
The freestyle search is enabled for the view elements TravelID, AgencyID and CustomerID using the annotation @Search.DefaultSearchElement.
The view elements AgencyName from the association _Agency and CustomerName from the association _Customer have been added to the projection list. They are specified as textual description for the view elements AgencyID and CustomerID respectively using the @ObjectModel.text.element annotation.
Value helps are specified for the view elements AgencyID, CustomerID, and CurrencyCode using the annotation @Consumption.valueHelpDefinition. The name of the target CDS entity that acts as a value help provider and the name of its element that is linked to the local element have to be specified.
The view element CurrencyCode is specified as the reference field for the currency fields BookingFee and TotalPrice using the @Semantics.amount.currencyCode annotations.
The view elements CreatedBy, CreatedAt and LastChangedBy have been removed from the projection list because they only have an are administrative function and will be of no use in our scenario. The view elements LastChangedAt and LocalLastChangedAt remain in the projection list because they will be used for the transactional enablement of Your Travel List Report App in week 3 – especially for the implementation of the optimistic lock.
associations have been exposed in the projection list
association to the booking BO child node (_Booking) has been redirected to the appropriate Booking BO projection view using the redirected to composition child statement.
*/
}
