package dev.fbdeferred.facebook_deferred_deep_link

import android.content.Context
import android.util.Log
import com.facebook.FacebookSdk
import com.facebook.LoggingBehavior
import com.facebook.applinks.AppLinkData
import io.flutter.embedding.engine.plugins.FlutterPlugin
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.resume

class FacebookDeferredDeepLinkPlugin :
    FlutterPlugin,
    FacebookDeferredDeepLinkPluginApi {
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        FacebookDeferredDeepLinkPluginApi.setUp(flutterPluginBinding.binaryMessenger, this)
    }

    override suspend fun fetchDeferredDeepLink(debug: Boolean): String? {
        if (debug) {
            FacebookSdk.setIsDebugEnabled(true)
            FacebookSdk.addLoggingBehavior(LoggingBehavior.REQUESTS)
            Log.d(TAG, "Fetching deferred deep link")
        }
        return try {
            val link = fetch()
            if (debug) Log.d(TAG, "Deferred deep link: ${link ?: "none"}")
            link
        } catch (e: Exception) {
            if (debug) Log.e(TAG, "Deferred deep link fetch failed", e)
            throw e
        }
    }

    private suspend fun fetch(): String? =
        suspendCancellableCoroutine { continuation ->
            AppLinkData.fetchDeferredAppLinkData(context) { appLinkData ->
                if (continuation.isActive) {
                    continuation.resume(appLinkData?.targetUri?.toString())
                }
            }
        }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        FacebookDeferredDeepLinkPluginApi.setUp(binding.binaryMessenger, null)
    }

    private companion object {
        const val TAG = "FacebookDeferredDeepLink"
    }
}
