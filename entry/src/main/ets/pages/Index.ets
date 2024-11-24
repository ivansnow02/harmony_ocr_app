import { DerivedNavPathStack, param } from '../common/NavPathStack';
import { FaceDetection } from './FaceDetection';
import { TableOCR } from './TableOCR';

@Entry
@Component
struct Index {
  private controller: TabsController = new TabsController()


  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
      TabContent() {
        TableOCR()
      }.tabBar(new BottomTabBarStyle($r('sys.media.ohos_ic_public_camera'), "表格识别"))

      TabContent() {
        FaceDetection()
      }.tabBar(new BottomTabBarStyle($r('sys.media.ohos_ic_public_camera'), "人脸识别"))

    }

  }
}

