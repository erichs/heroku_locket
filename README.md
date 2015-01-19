heroku_locket
=============


Lock-in app selections for your heroku commands, with ZSH support

## Usage

```shell
applock my-heroku-app  # supports tab-completion, sets RPROMPT
heroku logs            # targets my-heroku-app
appunlock              # releases lock
```

## Install

* clone this repo
* source heroku_locket.sh in your .zshrc

## License

MIT
