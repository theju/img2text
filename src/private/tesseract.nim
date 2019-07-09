type
  TessBaseAPI {.header: "<tesseract/baseapi.h>",
                importcpp: "tesseract::TessBaseAPI".} = object

type
  PIX {.header: "<leptonica/allheaders.h>",
        importcpp: "PIX".} = object

proc constructTessBaseAPI(): TessBaseAPI {.importcpp: "TessBaseAPI(@)", constructor.}

proc destroyTessBaseAPI(this: TessBaseAPI) {.importcpp: "#.~TessBaseAPI()".}

proc Init(this: TessBaseAPI, datapath: cstring, language: cstring): cint {.header: "<tesseract/baseapi.h>",
                                                                           importcpp: "TessBaseAPI::Init".}

proc End(this: TessBaseAPI): void {.header: "<tesseract/baseapi.h>",
                                    importcpp: "TessBaseAPI::End".}

proc SetImage(this: TessBaseAPI, pix: ref PIX): void {.header: "<tesseract/baseapi.h>",
                                                       importcpp: "TessBaseAPI::SetImage".}

proc GetUTF8Text(this: TessBaseAPI): cstring {.header: "<tesseract/baseapi.h>",
                                               importcpp: "GetUTF8Text".}

proc pixRead(path: cstring): ref PIX {.header: "<leptonica/allheaders.h>",
                                       importc: "pixRead".}

proc pixDestroy(pix: ptr ref PIX): void {.header: "<leptonica/allheaders.h>",
                                          importc: "pixDestroy".}

proc getText*(language: string, image: string): string {.raises: [IOError].} =
  let api = constructTessBaseAPI()

  let retVal = api.Init(nil, language)
  if retVal != 0:
    raise newException(IOError, "Invalid language")

  let pix = pixRead(image)
  if isNil(pix):
    api.End()
    pixDestroy(unsafeAddr(pix))
    raise newException(IOError, "Invalid Image")

  api.SetImage(pix)

  let outText = api.GetUTF8Text()

  api.End()
  pixDestroy(unsafeAddr(pix))

  destroyTessBaseAPI(api)

  if outText.isNil:
    return ""
  return $outText
