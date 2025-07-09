##########################
# Flutter core & plugins
##########################
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class com.andriirvansyah.cek_resi.MainActivity { *; }

# Tambahan penting untuk Flutter engine
-keep class io.flutter.embedding.engine.** { *; }
-keep class io.flutter.embedding.android.** { *; }

##########################
# Google Mobile Ads (AdMob)
##########################
-keep class com.google.android.gms.ads.** { *; }
-dontwarn com.google.android.gms.ads.**
-keep public class com.google.android.gms.common.internal.safeparcel.SafeParcelable {
    public static final *** NULL;
}

##########################
# Camera plugin
##########################
-keep class com.google.android.cameraview.** { *; }
-dontwarn com.google.android.cameraview.**

##########################
# Barcode scanner (ML Kit atau Zxing)
##########################
-keep class com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**
-keep class com.google.zxing.** { *; }
-dontwarn com.google.zxing.**

# Optional: Keep all classes that extend WebViewClient or WebChromeClient
-keep class * extends android.webkit.WebViewClient { *; }
-keep class * extends android.webkit.WebChromeClient { *; }

##########################
# Reflection safety
##########################
-keepattributes Signature,InnerClasses,EnclosingMethod
-keepclassmembers class * {
    *;
}

##########################
# AndroidX dan Support Library
##########################
-keep class androidx.** { *; }
-keep class android.support.** { *; }
-dontwarn androidx.**
-dontwarn android.support.**

##########################
# Java/Kotlin runtime
##########################
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }
-dontwarn kotlin.**
-keep class org.jetbrains.** { *; }
-dontwarn org.jetbrains.**

##########################
# R8/Proguard umum
##########################
-ignorewarnings
-dontobfuscate
-dontoptimize