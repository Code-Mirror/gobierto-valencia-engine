# Gobierto Valencia Engine

The purpose of this engine is to override views and styles of hosting gobierto application.

## Usage


## Installation
Previously you have to set `DEV_DIR` environment variable. Local gobierto application must be
under this path, i.e. the gobierto path must be `$DEV_DIR/gobierto`

Clone this repo and run `script/setup.sh`. It will create the following symbolic link in local
gobierto path: `$DEV_DIR/gobierto/vendor/gobierto_engines/gobierto-valencia-engine`.

After that, `gobierto-valencia-engine` will be available as theme in a site. Go to the
destination site configuration in admin and set `gobierto-valencia-engine` in "engine overrides param"
attribute

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
