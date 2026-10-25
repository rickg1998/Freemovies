# Free test hosting for RGShows metadata

[Deploy to Render](https://render.com/deploy?repo=https://github.com/rickg1998/Freemovies)

This repository includes a Render Blueprint for the self-hosted metadata service. It uses the Free instance plan, Python 3.12, the checked-in service ZIP, and Render-managed HTTPS. No custom domain or API key is needed for this self-hosted implementation.

## Deploy

1. Open the Deploy to Render link and sign in to Render (or create an account).
2. If asked, connect GitHub and select rickg1998/Freemovies.
3. Review the rgshows-metadata service and confirm that its instance plan is Free. Create/deploy the Blueprint.
4. Wait until Render marks the service Live. Copy its actual HTTPS onrender.com URL.
5. Open that URL followed by /health. It should return status ok.
6. Open /title/details?title_id=tt0111161 on that same URL. A real movie response verifies IMDb access; /health alone does not.
7. In the metadata-preview APK, use 3 sources → Settings → Movie metadata service and enter the base HTTPS URL without /health or /title/details.

Render login/creation and service deployment are performed in your own account. These files do not mean the service is already deployed. No Render account credentials are stored here.

## Limits relevant to the app

Render currently sleeps Free web services after 15 minutes without incoming traffic. Waking can take around a minute, so the app's first request after an idle period can time out. Wait for /health to respond and retry the app. No always-on guarantee is made.

The Free filesystem is temporary. SQLite here is only a reconstructible movie metadata cache; it resets when the instance sleeps, restarts or deploys. User watchlists/preferences remain in the phone app, not this database. Included usage limits also apply. This is a free testing/hobby deployment, not a production reliability fix for many users.

IMDb availability on Render's network is not yet verified. A 403, 429 or upstream error from /title/details must be investigated using Render logs. Do not treat a healthy process as proof of working movie data.

This service enables metadata and filtering. It does not supply or fix playable video streams from the three provider websites.

## Maintaining the deployment

render-build.sh verifies the exact service ZIP checksum before extracting it. When intentionally replacing RGShows-metadata-service.zip, update that checksum after reviewing and testing the new package. The Python service uses Render's PORT variable and HOST=0.0.0.0.

References: https://render.com/docs/free and https://render.com/docs/blueprint-spec
