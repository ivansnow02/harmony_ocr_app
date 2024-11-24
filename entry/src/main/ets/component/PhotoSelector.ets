import { BusinessError } from '@kit.BasicServicesKit';
import { photoAccessHelper } from '@kit.MediaLibraryKit';

@Component
export struct SelectButton {
  @Link fileUrl: string;
  @Link uploadState: number;

  build() {
    Button("选择图片")
      .margin(5)
      .onClick(async () => {

        this.uploadState = 0;
        try {
          let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
          PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
          PhotoSelectOptions.maxSelectNumber = 5;
          let photoPicker = new photoAccessHelper.PhotoViewPicker();
          photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult: photoAccessHelper.PhotoSelectResult) => {
            this.fileUrl = PhotoSelectResult.photoUris[0]
            console.info('PhotoViewPicker.select successfully, PhotoSelectResult uri: ' +
            this.fileUrl);
          }).catch((err: BusinessError) => {
            console.error(`PhotoViewPicker.select failed with err: ${err.code}, ${err.message}`);
          });
        } catch (error) {
          let err: BusinessError = error as BusinessError;
          console.error(`PhotoViewPicker failed with err: ${err.code}, ${err.message}`);
        }

      })

  }
}