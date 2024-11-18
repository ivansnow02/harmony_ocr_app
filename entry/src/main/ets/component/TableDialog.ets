import { webview } from "@kit.ArkWeb";

// xxx.ets
@CustomDialog
struct CustomDialogExample {
  @Link htmlUrl: string;
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
      }
    }
  }
}

@Component
export struct CustomDialogUser {
  @State htmlUrl: string = '';
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: ()=> { this.onCancel() },
      confirm: ()=> { this.onAccept() },
      htmlUrl: this.htmlUrl
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
      Button('click me')
        .onClick(() => {
          if (this.dialogController != null) {
            this.dialogController.open()
          }
        }).backgroundColor(0x317aff)
    }.width('100%').margin({ top: 5 })
  }
}