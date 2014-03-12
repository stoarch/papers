unit type_documentInfo;

interface

const
  DOCUMENT_SUBKIND_UNKNOWN = 0;

const
  DOCUMENT_KIND_UNKNOWN           = -1;
  DOCUMENT_KIND_COMMUNICATION     = 0;
  DOCUMENT_KIND_INTERNAL          = 1;
  DOCUMENT_KIND_ORGANIZATING      = 2;
  DOCUMENT_KIND_ORDERS            = 3;
  DOCUMENT_KIND_INCOMING          = 4;
  DOCUMENT_KIND_OUTGOING          = 5;

const
  MAX_FOLDERS = 6;

const
  DOCUMENT_KIND_COMMUNICATION_DB_ID     = 1;
  DOCUMENT_KIND_INTERNAL_DB_ID          = 2;
  DOCUMENT_KIND_ORGANIZATING_DB_ID      = 3;
  DOCUMENT_KIND_ORDERS_DB_ID            = 4;
  DOCUMENT_KIND_INCOMING_DB_ID          = 5;
  DOCUMENT_KIND_OUTGOING_DB_ID          = 6;

const
  COMMUNICATION_DOCUMENTS         = 0;
  INTERNAL_DOCUMENTS              = 1;
  ORGANIZATING_DOCUMENTS          = 2;
  ORDERS_DOCUMENTS                = 3;
  INCOMING_DOCUMENTS              = 4;
  OUTGOING_DOCUMENTS              = 5;

const
  COMMUNICATION_DOCUMENTS_DB_ID   = 1;
  INTERNAL_DOCUMENTS_DB_ID        = 2;

type
  TDocumentKind = type integer;

  TDocumentSubKind = type integer;

  TDocumentFlag    = type integer;

const
  DOCUMENT_STATE_UNKNOWN    = 0;
  DOCUMENT_STATE_PROCESSING = 1;

type
  TDocumentState   = type integer;


implementation

end.
 