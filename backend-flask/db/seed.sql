-- this file was manually created
INSERT INTO public.users (display_name, email, handle, cognito_user_id)
VALUES
  /*('Andrew Brown', 'andrew@exampro.co', 'andrewbrown' ,'f73f4a05-a59e-468a-8a29-a1c39e7a1111'), */
  ('Michael Josias', 'josiasmichael@gmail.com', 'mysycry' ,'64669d1f-2011-44c4-a7bd-0ba359787a17'),
  ('Josias Michael', 'josiasmichael2@gmail.com', 'josiasmichael2' ,'MOCK'),
  ('Andrew Bayko', 'bayko@exampro.co', 'bayko' ,'f73f4b05-a59e-468b-8a29-a1c39e7a2222'),
  ('Londo Mollari','lmollari@centari.com' ,'londo' ,'MOCK');

INSERT INTO public.activities (user_uuid, message, expires_at)
VALUES
  (
    (SELECT uuid from public.users WHERE users.handle = 'mysycry' LIMIT 1),
    'This was imported as seed data!',
    current_timestamp + interval '10 day'
  )