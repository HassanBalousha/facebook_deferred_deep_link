package dev.fbdeferred.facebook_deferred_deep_link

import android.content.Context
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

    override suspend fun fetchDeferredDeepLink(): String? =
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
}
