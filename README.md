# Image To Text

A simple web app (API) that accepts an image and returns the text in it. The OCR
is powered by the [Tesseract OCR Engine](https://github.com/tesseract-ocr/tesseract).

I wrote this application to evaluate the Nim language and it's [FFI
interface](https://nim-lang.org/docs/manual.html#foreign-function-interface).

## Installation

1. Install [Nim](https://nim-lang.org/install.html) which also installs Nimble, the
package manager.

2. Install the Leptonica and Tesseract libraries:
   ```
   sudo apt-get install libleptonica-dev libtesseract-dev
   ```
   
3. Build the code
   ```
   git clone https://github.com/theju/img2text.git
   cd img2text
   nimble build -d:release
   ```
   
4. Run the server
   ```
   ./img2text [--port=<port_num>]
   ```
   
5. Testing the application
   ```
   curl -XPOST -F "image=@some_image_file.jpg" http://localhost:5000/
   ```
   
## License

Licensed under the `MIT` license. Refer to the `LICENSE` file for more details.
