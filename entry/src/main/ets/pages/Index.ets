import { TableOCR } from './TableOCR';


@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          TableOCR()
        }
        .tabBar('表格扫描')

        TabContent() {
          Text('推荐的内容').fontSize(30)
        }
        .tabBar('推荐')

        TabContent() {
          Text('发现的内容').fontSize(30)
        }
        .tabBar('发现')

        TabContent() {
          Text('我的内容').fontSize(30)
        }
        .tabBar("我的")
      }
    }
    .height('100%')
    .width('100%')
  }
}