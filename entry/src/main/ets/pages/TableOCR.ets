import { common } from '@kit.AbilityKit';
import { webview } from '@kit.ArkWeb';
import { UploadButton } from '../component/PhotoUploader';
import { SelectButton } from '../component/PhotoSelector';
import {CustomDialogUser} from  '../component/TableDialog';


let context = getContext(this) as common.Context; // 请确保getContext(this)返回结果为UIAbilityContext
let cacheDir = context.cacheDir;


@Component
export struct TableOCR {
  @State message: string = '';
  @State fileUrl: string = '';
  controller: webview.WebviewController = new webview.WebviewController();

  build() {
    Row() {
      Column() {
        Image(this.fileUrl).width(200);

        SelectButton({
            fileUrl: this.fileUrl,
            message: this.message
          });

        UploadButton({
            api: '/ocr/table',
            fileUrl: this.fileUrl,
            message: this.message
          });




        //Web({ src: 'http://192.168.31.12:8080/static/table_20241116220513.html', controller: this.controller })
        //.onClick(
            // todo
          //)

        CustomDialogUser({
          htmlUrl: "/static/test1.html"
        })

      }
      .width('100%')
    }
    .height('100%')
  }
}