# RGShows 3.5 — Upcoming and browser playback

Android 12+, compile/target API 36. Version code 9. Same package ID and signing certificate for in-place updates. Default metadata service remains https://rgshows-metadata.onrender.com, with cold-start waiting and scheduled repository health checks retained.

## Upcoming
A native Upcoming tab lists future releases in release-date order. Home excludes known future releases. Search and My list can show both, with an UPCOMING badge on future titles. Full release dates are compared strictly with the phone's current local date; today's releases are not upcoming. Future year-only/month-only metadata can establish a future release period without inventing a day; current-year/current-month metadata without a future day is not assumed upcoming. Invalid and missing dates are not guessed. Unknown exact dates display date pending. Classification is recomputed on resume so it can change when the day changes.

The metadata service ZIP adds /upcoming?after=YYYY-MM-DD with a true next-day date constraint, nearest-first ordering and cursor pagination. The query requests release_date on the result cards. Genre/type/year constraints are retained. Countries/dates come from the metadata service, whose upstream default region is US. Release-date changes in the source may affect the classification.

## Browser playback — requested change
Selecting a source now opens its HTTPS website using Android ACTION_VIEW. An existing verified title link opens that page; an unavailable title link opens the provider homepage with a Browse website label. No invented title/search URLs are used. Users may need to search for the movie and press Play on the website. The native VideoView activity and stream resolver are removed, so their previous unsupported-stream error path is no longer used. This is a change of playback method, not a verified repair of native stream extraction. No claim that the source will autoplay or that the movie is available is made. The app's ad blocker cannot block external-browser ads; use the browser's own protection.

## Validation and deployment
153 local app checks pass, including 23 release/date precision/timezone checks. The backend has 46 passing offline tests. APK compilation, signing and manifest inspection passed. No physical-device/emulator playback or layout test was available. Live IMDb Upcoming-query verification remains outstanding.

The service ZIP and deployment checksum are updated in the same GitHub commit as the APK. Let Render deploy that commit before testing Upcoming. If auto-deploy is disabled, use Render's Deploy latest commit. The app can fall back to year-bounded search on older services until deployment finishes, but this is less complete than the new endpoint.
