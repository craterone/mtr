# mtr

mtr wrapper 

https://github.com/traviscross/mtr

## dependencies

> * [mtr 0.92 ](https://github.com/traviscross/mtr)
> * [crystal](https://crystal-lang.org/) 

## build

> * crystal deps
> * make

## release & install

**Only supported in Linux X86_64**

> * make install

## Usage

```
   mtr-online - MTR command wrapper , and send the report to the server

  Usage:
    mtr-online [flags] [arguments]

  Commands:
    help [command]  # Help about any command.

  Flags:
    -a, --address  # The address for mtr test. default: 'baidu.com'.
    -h, --help     # Help for this command. default: 'false'.
    -n, --name     # the name of the tester  default: 'abc'.
    -s, --server   # The server for storing the report. default: 'http://tmp-test.server.linctime.com:3300/record'.
```


