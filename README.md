# dbfp-tsv

## Local Setup

1. Run `docker compose up --build` (append -d if you don't want to see the terminal messages)
1. Run `docker compose yarn custom-build`
1. Navigate to http://localhost:8080
1. Open your page inspector (and keep it open) so that you can bust the caching.
1. When you need to rebuild the files (after adding/editing files in `./src/`), it is best to run  
    `docker compose exec dbfp yarn custom-build`  
    in some cases, you may need to hard-reload your web browser when the custom-build finishes.
