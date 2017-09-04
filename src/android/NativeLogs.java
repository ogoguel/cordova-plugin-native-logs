package com.del7a.nativelogs;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.LinkedList;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.LOG;
import org.json.JSONArray;
import org.json.JSONException;

import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;

public class NativeLogs extends CordovaPlugin {

    private final String LOG_TAG = "CDVLOGCAT";

    private void clearLog() {

        LOG.d(LOG_TAG, "clearLog");

        try {
            Runtime.getRuntime().exec("logcat -c");
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {

        super.initialize(cordova, webView);
        this.clearLog();
    }

    private  String getLogsFromLogCat(int _nbLines) {

        LinkedList<String> logs = new LinkedList<String>();

        try {
            Process process = Runtime.getRuntime().exec("logcat -d");
            BufferedReader bufferedReader = new BufferedReader(
                    new InputStreamReader(process.getInputStream()));

            String line ;
            while (( line = bufferedReader.readLine()) != null) {
                logs.add(line);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        String log = "";

        int nb = 0;
        while( (nb < _nbLines) && (logs.size() > 0) ) {
            log += logs.getLast();
            log += "\n";
            logs.removeLast();
            nb++;
        }
        return log;
    }

    public boolean execute(String action, JSONArray args, CallbackContext callbackContext)
            throws JSONException {

        if (action.equals("getLog")) {

            int nbLines = args.getInt(0);
            boolean bCopyToClipBoard = args.getBoolean(1);

            String log = getLogsFromLogCat(nbLines);

            if (bCopyToClipBoard) {
                ClipboardManager clipboard = (ClipboardManager) cordova.getActivity().getSystemService(Context.CLIPBOARD_SERVICE);
                ClipData clip = ClipData.newPlainText("logcat", log);
                clipboard.setPrimaryClip(clip);
            }
            callbackContext.success(log);
            return true;

        }
        else
            return false;
    }


}
