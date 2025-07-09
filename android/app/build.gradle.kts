import java.util.Properties
import java.io.FileInputStream
import java.io.File

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.andriirvansyah.cek_resi"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.andriirvansyah.cek_resi"
        minSdk = 23
        targetSdk = 35
        versionCode = 8
        versionName = "1.0.7"
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
                ?: throw GradleException("Property 'keyAlias' tidak ditemukan di key.properties")
            keyPassword = keystoreProperties.getProperty("keyPassword")
                ?: throw GradleException("Property 'keyPassword' tidak ditemukan di key.properties")
            storeFile = keystoreProperties.getProperty("storeFile")?.let { file(it) }
                ?: throw GradleException("Property 'storeFile' tidak ditemukan di key.properties")
            storePassword = keystoreProperties.getProperty("storePassword")
                ?: throw GradleException("Property 'storePassword' tidak ditemukan di key.properties")
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                file("proguard-rules.pro")
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.android.gms:play-services-ads:24.4.0")
}