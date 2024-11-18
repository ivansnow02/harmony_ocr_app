import { common } from '@kit.AbilityKit';
import { BusinessError, request } from '@kit.BasicServicesKit';
import fs from '@ohos.file.fs';

let context = getContext(this) as common.Context; // 请确保getContext(this)返回结果为UIAbilityContext
let cacheDir = context.cacheDir;

interface iHeader {
  key1: string;
  key2: string;
}

interface iFile {
  filename: string;
  name: string;
  uri: string;
  type: string;
}

interface iData {
  name: string;
  value: string;
}

interface iUploadConfig {
  url: string;
  header: iHeader;
  method: string;
  files: iFile[];
  data: iData[];
}


@Component
export struct UploadButton {
  @State api: string = '';
  @Link fileUrl: string;
  @Link message: string;

  build() {
    Button("上传")
      .onClick(async () => {

        let uploadConfig: iUploadConfig = {
          url: 'http://100.108.98.108:8080' + this.api,
          header: ({ key1: 'Content-Type', key2: 'multipart/form-data' } as iHeader),
          method: 'POST',
          files: [({
            filename: 'test.png',
            name: 'img',
            uri: 'internal://cache/test.png',
            type: 'png'
          } as iFile)],
          data:
          [({ name: 'fileId', value: 'FP000008' } as iData)]


        }


        let file = fs.openSync(this.fileUrl, fs.OpenMode.CREATE);
        fs.copyFileSync(file.fd, cacheDir + "/test.png");

        console.log("1");
        let uploadTask: request.UploadTask;
        // 将本地应用文件上传至网络服务器
        try {
          request.uploadFile(getContext(), uploadConfig).then((data: request.UploadTask) => {
            uploadTask = data;
            let upCompleteCallback = (taskStates: Array<request.TaskState>) => {
              for (let i = 0; i < taskStates.length; i++) {
                console.info("upOnComplete taskState:" + JSON.stringify(taskStates[i]));
              }
            };
            uploadTask.on('complete', upCompleteCallback);
            let headerCallback = (headers: object) => {
              this.message = JSON.parse(JSON.stringify(headers)).body
              console.log(this.message)
            };
            uploadTask.on('headerReceive', headerCallback);
          }).catch((err: BusinessError) => {
            console.error(`Failed to request the upload. Code: ${err.code}, message: ${err.message}`);
          });
        } catch (err) {
          console.error(`Failed to request the upload. err: ${JSON.stringify(err)}`);
        }


      }
      )

  }
}