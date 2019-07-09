# Package

version       = "0.0.1"
author        = "Thejaswi Puthraya"
description   = "Image to Text powered by Tesseract OCR"
license       = "MIT"
srcDir        = "src"
bin           = @["img2text"]
backend       = "cpp"


# Dependencies

requires "nim >= 0.19.4"
requires "jester"
