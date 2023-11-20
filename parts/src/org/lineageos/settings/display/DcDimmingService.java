/*
 * Copyright (C) 2023 Paranoid Android
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package org.lineageos.settings.display;

import static android.provider.Settings.System.DC_DIMMING_STATE;
import static org.lineageos.settings.display.DfWrapper.DfParams;

import android.app.Service;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.database.ContentObserver;
import android.os.Handler;
import android.os.IBinder;
import android.os.UserHandle;
import android.provider.Settings;
import android.util.Log;

public class DcDimmingService extends Service {

    private static final String TAG = "DcDimmingService";

    private boolean mIsDcDimmingEnabled;
    private boolean mIsScreenOn;

    private Handler mHandler = new Handler();

    private final ContentObserver mSettingObserver = new ContentObserver(mHandler) {
        @Override
        public void onChange(boolean selfChange) {
            Log.e(TAG, "SettingObserver: onChange");
            updateDcDimming();
        }
    };

    @Override
    public void onCreate() {
        super.onCreate();
        dlog("Creating service");
        getContentResolver().registerContentObserver(Settings.System.getUriFor(DC_DIMMING_STATE),
                    false, mSettingObserver, UserHandle.USER_CURRENT);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        dlog("Starting service");
        updateDcDimming();
        return START_STICKY;
    }

    @Override
    public void onDestroy() {
        dlog("Destroying service");
        getContentResolver().unregisterContentObserver(mSettingObserver);
        super.onDestroy();
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    public static void startService(Context context) {
        context.startServiceAsUser(new Intent(context, DcDimmingService.class), UserHandle.CURRENT);
    }

    private void updateDcDimming() {
        final int enabled = Settings.System.getInt(getContentResolver(),
                Settings.System.DC_DIMMING_STATE, 0);
        dlog("updateDcDimming: enabled=" + enabled);
        try {
            DfWrapper.setDisplayFeature(
                    new DfWrapper.DfParams(/*DC_BACKLIGHT_STATE*/ 20, enabled, 0));
        } catch (Exception e) {
            Log.e(TAG, "updateDcDimming failed!", e);
        }
    }

    private static void dlog(String msg) {
        if (Log.isLoggable(TAG, Log.DEBUG)) {
            Log.d(TAG, msg);
        }
    }
}
