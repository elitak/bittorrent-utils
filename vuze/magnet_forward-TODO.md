- Delayed close on notification window
- better handling of errors
- client-agnostic forwarding (vuze webui is assumed for now)
- Add run mode where no args results in:
   1. registering the magnet handler, with confirmation
   2. showing options dialog to configure all the hard-coded stuff in here
- Options Dialog:
   * A list of configured URIs to forward the link to
   * a column of checkboxes to select the default(s) (support multiple)
   * a "prompt" checkbox that results in a dialog when running with the magnet URI arg:
     - checkbox + labels appear with defaults checked,
       each select to which URIs the magnet should be forwarded
     - OK button to confirm

