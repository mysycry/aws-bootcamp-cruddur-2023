-- this file was manually created
INSERT INTO public.users (display_name, email, handle, cognito_user_id)
VALUES
  ('Andrew Brown', 'andrew@exampro.co', 'andrewbrown' ,'MOCK'),
  ('Michael Josias', 'josiasmichael@gmail.com', 'mysycry' ,'MOCK'),
  ('Andrew Bayko', 'bayko@exampro.co', 'bayko' ,'MOCK');

INSERT INTO public.activities (user_uuid, message, expires_at)
VALUES
  (
    (SELECT uuid from public.users WHERE users.handle = 'mysycry' LIMIT 1),
    'This was imported as seed data!',
    current_timestamp + interval '10 day'
  )