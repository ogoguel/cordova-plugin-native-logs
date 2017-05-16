import { Component } from '@angular/core';
import { NavController, ViewController,NavParams } from 'ionic-angular';

@Component({
  selector: 'page-log',
  templateUrl: 'log.html'
})
export class LogPage {

	public logs:string

  constructor(public navCtrl: NavController, public viewCtrl: ViewController, public navParams: NavParams) {
		this.logs = navParams.get("logs");
	}

	closeModal(){
		 this.viewCtrl.dismiss();
	}

}
