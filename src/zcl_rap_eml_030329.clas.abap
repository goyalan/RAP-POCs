CLASS zcl_rap_eml_030329 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_RAP_EML_030329 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Read syntax 1
    READ ENTITIES OF zi_rap_travel_30329
    ENTITY travel
    FROM  VALUE #( ( TravelUUID = '' ) )
    RESULT DATA(travels).

    out->write( travels ) .

    "Short explanation:
    "The READ ENTITIES statement followed by our travel business object is used for
    " the purpose.
    "The entity for which we want to perform the operation is specified.
    "In our case the travel entity.
    "All EML statements are mass-enabled by default, therefore, the list of keys
    " for which the READ operation should be performed needs to be specified.
    "The result of the read is put into the table travels declared inline.
    "Finally, the console is used to show the content of the result table.

    "read syntax 2 (pass uuid)
    READ ENTITIES OF zi_rap_travel_30329
    ENTITY Travel
    FROM VALUE #(  ( TravelUUID = '' ) )
    RESULT travels .

    out->write( travels ) .

    "read syntax 2 (pass uuid)/ in output only uuid will come rest all fields will show blank values
    READ ENTITIES OF zi_rap_travel_30329
    ENTITY Travel
    FROM VALUE #(  ( TravelUUID = '6FF90270E06490811800A7C2E802FB3B' ) )
    RESULT travels .
    out->write( 'Output 2' ) .
    out->write( travels ) .

    "read syntax 3 (pass uuid)/ in output all fields
    READ ENTITIES OF zi_rap_travel_30329
    ENTITY Travel
    ALL FIELDS WITH
    "from
    VALUE #(  ( TravelUUID = '6FF90270E06490811800A7C2E802FB3B' ) )
    RESULT travels .
    out->write( 'Output 3' ) .
    out->write( travels ) .



    "read syntax 4 (pass uuid)/ in output specific field
    READ ENTITIES OF zi_rap_travel_30329
    ENTITY Travel
    FIELDS (  AgencyID CustomerID ) WITH
    "from
    VALUE #(  ( TravelUUID = '6FF90270E06490811800A7C2E802FB3B' ) )
    RESULT travels .
    out->write( 'Output 4' ) .
    out->write( travels ) .


    "read syntax 5 (pass uuid)/ in output specific field of assosiated entity perform a read-by-association,
    READ ENTITIES OF zi_rap_travel_30329
    ENTITY Travel BY \_Booking
    FIELDS ( BookingID BookingUUID  ) WITH
    "from
    VALUE #(  ( TravelUUID = '6FF90270E06490811800A7C2E802FB3B' ) )
    RESULT DATA(bookings) .
    out->write( 'Output 5' ) .
    out->write( bookings ) .

    "When performing EML read operations, you should not only consider the result table
    "but also take the failed and the reported tables into account. Failed keyword is used to
    "convey unsuccessful operations.
    " Reported keyword is optionally used to provide related T100 messages.
    READ ENTITIES OF zi_rap_travel_30329
    ENTITY Travel
    ALL FIELDS WITH
    "from
    VALUE #(  ( TravelUUID = '6FF90270E06490811800A7C2E802FB3B' ) )
    RESULT travels
    FAILED DATA(FAILED_table)
    REPORTED DATA(REPORTED_table).

    out->write( 'Output 6' ) .
    out->write( travels ) .
    out->write( failed_table ).    " complex structures not supported by the console output
    out->write( reported_table ).  " complex structures not supported by the console output


    "modify syntax , it also requires commit
    MODIFY ENTITIES OF ZI_RAP_Travel_30329
           ENTITY travel
             UPDATE
               SET FIELDS WITH VALUE
                 #( ( TravelUUID  = '6FF90270E06490811800A7C2E802FB3B'
                      Description = 'ankit' ) )

          FAILED DATA(failed)
          REPORTED DATA(reported).

    out->write( 'Update done' ).
    " step 6b - Commit Entities
    COMMIT ENTITIES
      RESPONSE OF ZI_RAP_Travel_30329
      FAILED     DATA(failed_commit)
      REPORTED   DATA(reported_commit).

    "The creation of new entities is performed using the MODIFY statement with the CREATE clause. For operations that create instances, a mapped table is returned which maps the created instance to the provided content ID.
    "You will now create a new travel instance. For that, comment out the current implementation and insert the code snippet provided below.
    "Do not forget to replace the placeholder #### with your chosen suffix.

    " step 7 - MODIFY Create
    MODIFY ENTITIES OF ZI_RAP_Travel_30329
      ENTITY travel
        CREATE
          SET FIELDS WITH VALUE
            #( ( %cid        = 'MyContentID_1' "components related to bdef derived types-bo instance and key
"cid is used in RAP create operations and then performing further, referencing modifications on them using %cid_ref, for example,
" RAP operations with CREATE BY, UPDATE and DELETE, as well as actions with EXECUTE, in a single ABAP EML MODIFY request.
"Furthermore, %cid must be filled because it is relevant for the RAP BO instance identification in the RAP response parameters
"mapped, failed and reported.
"Use of Keys and RAP BO Instance Identifiers in a Nutshell
"◾%cid
"◾%cid_ref
"%cid_ref is a component of BDEF derived types. It is used as a reference to a RAP BO
 "instance for which %cid has been specified manually. The value of %cid_ref is the same string as %cid that is referred to.
 "This %cid must exist in the same ABAP EML MODIFY request. Thus, %cid_ref cannot be used to refer to a particular %cid from anothe
"r request.
"◾%is_draft
"The draft indicator %is_draft is a component of BDEF derived types. It is used
 "to indicate if a RAP BO instance is a drafts instance or an active instance. To create a draft instance, %is_draft must be explicitly
 " set in ABAP EML MODIFY requests.
"◾%key
"%key is a component group in BDEF derived types. The component group contains
 "the primary key fields of a RAP BO instance. Thus, it serves as an identifier for persisted instances
"◾%pid
"%pid is a component of BDEF derived types and of type ABP_BEHV_PID. It is
"used as a preliminary ID for RAP BO instances and only available if late numbering is
"defined in the BDEF. In the RAP save sequence, %pid is transformed to the final key values.
"◾%pky
"It serves as an identifier in a transaction in which a RAP BO instance is created. In non-late numbering scenarios, %pky is equal
 "to %key (and, thus, serves also as an identifier for persisted RAP BO instances). In a late numbering scenario, it is equal
" to the combination of %pid and %key. This identifier does not change between the creation of an instance and the next saving.
"◾%pre
"◾%tky
"%tky is a component group in BDEF derived types and specifies the transactional key. A RAP BO instance must always be uniquely identifiable
" by its transactional key for internal processing during the RAP interaction phase.
"%tky contains %key and the draft indicator %is_draft as components which makes it particularly suitable for draft scenarios

"◾%tmp


          "
                 AgencyID    = '70012'
                 CustomerID  = '14'
                 BeginDate   = cl_abap_context_info=>get_system_date( )
                 EndDate     = cl_abap_context_info=>get_system_date( ) + 10
                 Description = 'I like RAP@openSAP' ) )

     MAPPED DATA(mappeds)
     FAILED DATA(faileds)
     REPORTED DATA(reporteds).

    out->write( mappeds-travel ).

    COMMIT ENTITIES
      RESPONSE OF ZI_RAP_Travel_30329
      FAILED     DATA(failed_commits)
      REPORTED   DATA(reported_commits).

    out->write( 'Create done' ).


" step 8 - MODIFY Delete
    MODIFY ENTITIES OF ZI_RAP_Travel_30329
      ENTITY travel
        DELETE FROM
          VALUE
            #( ( TravelUUID  = '6FF90270E06490811800A7C2E802FB3B' ) )

     FAILED DATA(failed_01)
     REPORTED DATA(reported_01).

    COMMIT ENTITIES
      RESPONSE OF ZI_RAP_Travel_30329
      FAILED     DATA(failed_commitED)
      REPORTED   DATA(reported_commitED).

    out->write( 'Delete done' ).



  ENDMETHOD.
ENDCLASS.
