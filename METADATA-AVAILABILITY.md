# Metadata service availability

The app endpoint is https://rgshows-metadata.onrender.com .

The RGShows metadata health workflow checks /health at minutes 7,17,27,37,47,57 each hour. This is scheduled every 10 minutes, away from the top of the hour, with bounded retries. It does not run IMDb searches or title-detail requests, so keeping the process awake does not repeatedly scrape movie metadata.

The workflow runs once when its file is pushed and can also be run manually in the repository's Actions tab. It needs no secrets or repository write permission. Check the latest run status here: https://github.com/rickg1998/Freemovies/actions/workflows/metadata-health.yml .

This is best effort. GitHub schedules may be delayed. Public-repository schedules are disabled after 60 days without repository activity; re-enable them in Actions if needed. Render may still restart or suspend a Free service. The schedule does not provide an always-on service guarantee. Do not use artificial repository commits to reset GitHub's inactivity timer.

RGShows 3.4 preconfigures this endpoint and adds up to 90 seconds of foreground-initiated cold-start handling. It does not add a periodic Android background job. A health check verifies the Python API process and its routes, not IMDb or video-source availability.

References: https://render.com/docs/free and https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows
