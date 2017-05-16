import { Component } from '@angular/core';
import { NavController, ModalController } from 'ionic-angular';
import { LogPage } from '../log/log';

declare var NativeLogs:any;

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  constructor(public navCtrl: NavController, public modalCtrl: ModalController) {

  }

  addLog() {
  	console.log("new log");
  }
  viewLogs() {
  		let __this : HomePage = this
  		
  		 if (typeof NativeLogs == "undefined") {
  		 	let m = __this.modalCtrl.create(LogPage,{logs:"not on device"})
	        m.present()
  		 	}
  		 else
  			 NativeLogs.getLog(
  			1000,
  			false,
            function (_logs) {
               let m = __this.modalCtrl.create(LogPage,{logs:_logs})
	         	m.present()
        });
  	}

}
