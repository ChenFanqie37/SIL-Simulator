const {app,BrowserWindow,Menu}=require('electron');
const path=require('path');
let mainWindow;
function createWindow(){
  mainWindow=new BrowserWindow({
    width:420,
    height:780,
    minWidth:360,
    minHeight:640,
    maxWidth:500,
    maxHeight:900,
    resizable:true,
    title:'韩娱嫂嫂模拟器',
    icon:path.join(__dirname,'icon.ico'),
    webPreferences:{
      preload:path.join(__dirname,'preload.js'),
      nodeIntegration:false,
      contextIsolation:true
    }
  });
  mainWindow.loadFile('index.html');
  Menu.setApplicationMenu(null);
  mainWindow.on('closed',()=>{mainWindow=null;});
}
app.whenReady().then(createWindow);
app.on('window-all-closed',()=>{if(process.platform!=='darwin')app.quit();});
app.on('activate',()=>{if(BrowserWindow.getAllWindows().length===0)createWindow();});
