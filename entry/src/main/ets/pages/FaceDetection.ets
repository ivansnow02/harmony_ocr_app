import { DerivedNavPathStack } from "../common/NavPathStack";
import { FaceDialog } from "../component/FaceDialog";
import { SelectButton } from "../component/PhotoSelector"
import { UploadButton } from "../component/PhotoUploader";


@Component
export struct FaceDetection{
  @State fileURL: string = '';
  @State message: string = '';
  @State uploadState: number = 0;

  build() {
    Column() {
      SelectButton({
        fileUrl: this.fileURL,
        uploadState: this.uploadState
      })
      UploadButton({
        fileUrl: this.fileURL,
        api: "/api/v1/face",
        message: this.message,
        uploadState: this.uploadState
      })

      FaceDialog({
        message:this.message,
        imgUrl: "/static/test.png"
      })
    }
  }



}