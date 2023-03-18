from datetime import datetime, timedelta, timezone
from aws_xray_sdk.core import xray_recorder

class UserActivities:
  def run(user_handle):
    # Xray -----
    # segment = xray_recorder.begin_segment('user_activities')
    model = {
      'errors': None,
      'data': None
    }

    now = datetime.now(timezone.utc).astimezone()



    if user_handle == None or len(user_handle) < 1:
      model['errors'] = ['blank_user_handle']
    else:
      now = datetime.now()
      results = [{
        'uuid': 'f450db40-4f00-46db-8472-7f461d1016b0',
        'handle':  'Michael Josias',
        'message': 'Cloud is good. All the time.',
        'created_at': (now - timedelta(days=1)).isoformat(),
        'expires_at': (now + timedelta(days=31)).isoformat()
      }]
      model['data'] = results

    # subsegment = xray_recorder.begin_subsegment('mock-data')
    # Xray -----
    # dict = {
    #  "now": now.isoformat(),
    #  "results-size": len(model['data'])
    # }
    # subsegment.put_metadata('key', dict, 'namespace')

    return model