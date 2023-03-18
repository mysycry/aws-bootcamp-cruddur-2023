from datetime import datetime, timedelta, timezone
class SearchActivities:
  def run(search_term):
    model = {
      'errors': None,
      'data': None
    }

    now = datetime.now(timezone.utc).astimezone()

    if search_term == None or len(search_term) < 1:
      model['errors'] = ['search_term_blank']
    else:
      results = [{
        'uuid': 'f450db40-4f00-46db-8472-7f461d1016b0',
        'handle':  'Michael Josias',
        'message': 'Cloud is good. All the time.',
        'created_at': now.isoformat()
      }]
      model['data'] = results
    return model