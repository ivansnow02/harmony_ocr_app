import { webview } from "@kit.ArkWeb";
import { BusinessError, request } from "@kit.BasicServicesKit";
import { common } from "@kit.AbilityKit";

let context = getContext(this) as common.Context;
let filesDir = context.filesDir;
// xxx.ets
@CustomDialog
struct CustomDialogExample {
  @Link htmlUrl: string;
  @Link xlsxUrl: string;
  controller?: CustomDialogController
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }
  wcontroller: webview.WebviewController = new webview.WebviewController();
  build() {
    Column() {
      Web({ src: 'http://100.108.98.108:8080'+this.htmlUrl, controller: this.wcontroller })
        .width(350)
        .height(300)
        // .textAutosizing(true)
        .initialScale(90)
      Row() {
        Button('取消')
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close()
            }
          })
          .margin(20)
        SaveButton()
          .onClick(
            () => {
              try {
                request.downloadFile(getContext(), {
                  url: 'http://100.108.98.108:8080'+this.xlsxUrl,
                  filePath: filesDir + "/test1.xlsx"
                }).then((downloadTask: request.DownloadTask) => {
                  downloadTask.on('complete', () => {
                    console.info('download complete');

                  })
                }).catch((err: BusinessError) => {
                  console.error(`Invoke downloadTask failed, code is ${err.code}, message is ${err.message}`);
                });
              } catch (error) {
                let err: BusinessError = error as BusinessError;
                console.error(`Invoke downloadFile failed, code is ${err.code}, message is ${err.message}`);
              }
            }
          )
      }
    }
  }
}

@Component
export struct CustomDialogUser {
  @State htmlUrl: string = '';
  @Link message: string;
  @State xlsxUrl: string = '';
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: ()=> { this.onCancel() },
      confirm: ()=> { this.onAccept() },
      htmlUrl: this.htmlUrl,
      xlsxUrl: this.xlsxUrl
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
          if (this.dialogController != null) {
            this.dialogController.open()
          }
        }).enabled(this.message===''?false:true)
    }.width('100%').margin({ top: 5 })
  }
}