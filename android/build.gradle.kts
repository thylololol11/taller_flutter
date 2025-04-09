plugins {
    id("com.android.application") apply false
    id("org.jetbrains.kotlin.android") version "1.8.22" apply false // Asegúrate de usar la versión correcta
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = layout.buildDirectory.dir("../../build").get()
rootProject.buildDir = newBuildDir.asFile // Usar buildDir directamente

subprojects {
    val newSubprojectBuildDir: File = File(newBuildDir.asFile, project.name) // Usar File directamente
    project.buildDir = newSubprojectBuildDir // Usar buildDir directamente
}

subprojects {
    evaluationDependsOn(":app")
}

tasks.register("clean", Delete::class) { // Sintaxis correcta para registrar tarea con tipo
    delete(rootProject.buildDir) // Usar buildDir directamente
}