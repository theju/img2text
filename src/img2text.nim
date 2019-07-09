import os
import times
import jester
import system
import parseopt
import strutils

from private/tesseract import getText

router customRouter:
  post "/":
    let fd = request.formData
    try:
      let img = fd["image"]
    except IndexError:
      resp Http400, "Image not found"
    let currDt = now()
    let tmpDir = getTempDir()
    let fName = currDt.format("yyyyMMddhhmmssffffff")
    let imgPath = joinPath(tmpDir, fName)
    let ff = open(imgPath, fmReadWrite)
    ff.write(fd["image"].body)
    ff.close()
    var outText = ""
    try:
      outText = getText("eng", imgPath)
    except IOError as ex:
      resp Http400, ex.msg
    finally:
      discard tryRemoveFile(imgPath)
    resp $outText

proc main() =
  var port = Port(5000)
  for kind, key, value in getopt(commandLineParams()):
    if kind == cmdLongOption and key == "port":
      port = Port(value.parseInt())
    elif kind == cmdShortOption and key == "p":
      port = Port(value.parseInt())
  let ns = newSettings(port=port)
  var jester = initJester(customRouter, settings=ns)
  jester.serve()

when isMainModule:
  main()
