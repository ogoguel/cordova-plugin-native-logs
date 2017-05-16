declare namespace NativeLogsPlugin {
    interface NativeLogs {
        /**
         * Retrieve the log files
         * @param nbLines          The max number of lines
         * @param bCopyToClipboard Copy the log to the clipboard
         * @param success:         callback to retrieve the log
         * @param failure:         Optional callback invoked in case of an error
         *
         */
        getNativeLogs(
            nbLines: number,
            bCopyToClipboard: boolean,
            success: (logs: string) => void): void;
            failure?: (error: string) => void): void;

       
    }
}

interface Window {
    NativeLogs: NativeLogsPlugin.NativeLogs;
}

declare var NativeLogs: NativeLogsPlugin.NativeLogs;