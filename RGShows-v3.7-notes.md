# RGShows 3.7 — IMDb ratings and visible My List controls

Android 12+, target/compile API 36. Version code 11, same application ID and signing certificate. No metadata-server change required.

## Ratings
Cards show the IMDb rating with a star and source label. Movie details show the score out of 10 and vote count when supplied. The API's rating.value and rating.vote_count are used; search results can display scores before full detail enrichment completes. Valid scores are finite values above 0 and at most 10. Missing/invalid ratings show IMDb — on cards and rating unavailable in details; no score is invented. Scores and vote counts survive catalog serialization, caching and merging. Missing ratings serialize as JSON null rather than NaN, so saving an unrated title cannot invalidate the catalog JSON.

## My List
Every movie card has a visible + My List button, changing to Saved after adding. The embedded player also has a + List / Saved control. Details keep their save/remove control. Save taps are separate from poster/card playback taps; card click handling no longer depends on GridView forwarding an item click when the row contains focusable controls. Save/remove feedback is immediate.

Entering My List clears active browsing filters so they do not hide saved titles. Saving ensures the title record exists in the local catalog. Removal clears old aliases as well as the canonical ID. Background metadata/source updates reload the latest profile before writing, preventing an older activity instance from overwriting a save/remove action made in the player.

## Validation
31 new checks cover valid/missing/invalid ratings, JSON round trips, save/remove/reopen, unrated-title persistence, alias removal, and interleaved catalog/player updates using the real Library code with an in-memory SharedPreferences implementation. Existing 187 app/adapter checks continue to pass (218 total). APK compilation, signature and manifest inspection passed. No physical phone/emulator touch-layout or on-disk Android persistence test was performed.

Embedded website playback, source matching, Upcoming and progressive metadata loading retain their previous behavior and limitations. This release does not claim new live provider-playback verification.
