import { webview } from "@kit.ArkWeb";
import { BusinessError, request } from "@kit.BasicServicesKit";
import { common } from "@kit.AbilityKit";


let context = getContext(this) as common.Context;
let filesDir = context.filesDir;



@CustomDialog
struct faceDialog {
  @Link imgUrl: string;
  @Link message: string;
  @State text: string[] = [];
  controller?: CustomDialogController
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }
  wcontroller: webview.WebviewController = new webview.WebviewController();
  build() {
    Column() {
      Image('http://100.108.98.108:8080'+this.imgUrl)
        .width(350)
        .height(300)
      List({ space: 20, initialIndex: 0 }) {
        ForEach(this.text, (item: number) => {
          ListItem() {
            Text('' + item)
              .width('100%').height(100).fontSize(16)
              .textAlign(TextAlign.Center).borderRadius(10).backgroundColor(0xFFFFFF)
          }
        }, (item: string) => item)
      }
      .listDirection(Axis.Vertical)
      Row() {
        Button('取消')
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close()
            }
          })
          .margin(20)

      }
    }
  }
}

@Component
export struct FaceDialog {
  @State imgUrl: string = '';
  @State text: string[] = [];
  @Link message: string;



  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: faceDialog({
      cancel: ()=> { this.onCancel() },
      confirm: ()=> { this.onAccept() },
      imgUrl: this.imgUrl,
      message: this.message,
      text: this.text
    }),
    cancel: this.existApp,
    autoCancel: true,
    onWillDismiss:(dismissDialogAction: DismissDialogAction)=> {
      console.info("reason=" + JSON.stringify(dismissDialogAction.reason))
      console.log("dialog onWillDismiss")
      if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
        dismissDialogAction.dismiss()
      }
      if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
        dismissDialogAction.dismiss()
      }
    },
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    showInSubWindow: true,
    isModal: true,
    customStyle: false,
    cornerRadius: 10,
  })
  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
  }

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  existApp() {
    console.info('Click the callback in the blank area')
  }

  build() {
    Column() {
      Button('查看结果')
        .onClick(() => {
          if (this.message !== '' && this.message){
          this.imgUrl = JSON.parse(this.message).imgPath
          this.text = JSON.parse(this.message).faceDesc}
          console.log(this.imgUrl)
          if (this.dialogController != null) {
            this.dialogController.open()
          }
        }).enabled(this.message===''?false:true)
    }.width('100%').margin({ top: 5 })
  }
}