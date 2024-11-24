import { common } from '@kit.AbilityKit';
import { webview } from '@kit.ArkWeb';
import { UploadButton } from '../component/PhotoUploader';
import { SelectButton } from '../component/PhotoSelector';
import { CustomDialogUser } from '../component/TableDialog';


let context = getContext(this) as common.Context; // 请确保getContext(this)返回结果为UIAbilityContext
let cacheDir = context.cacheDir;

@Styles
function itemStyle() {
  .width(336)
  .height(621)
  .margin({ top: 48, left: 12 })
  .borderRadius(24)
  .backgroundColor('#FFFFFF')
}


@Component
export struct TableOCR {
  @State uploadState: number = 0;
  @State message: string = '';
  @State fileUrl: string = '';
  controller: webview.WebviewController = new webview.WebviewController();

  build() {


    Column() {
      Image(this.fileUrl).width(200);

      SelectButton({
        fileUrl: this.fileUrl,
        uploadState: this.uploadState
      })


      UploadButton({
        api: '/api/v1/table',
        fileUrl: this.fileUrl,
        message: this.message,
        uploadState: this.uploadState
      });

      CustomDialogUser({
        htmlUrl: "/static/test1.html",
        xlsxUrl: "/static/test1.xlsx",
        message:this.message
      })

    }

  }
}