.class Lcom/android/internal/policy/impl/PhoneWindowManager$ThreeFingerCallbacks;
.super Ljava/lang/Object;
.source "PhoneWindowManager.java"

# interfaces
.implements Lcom/android/internal/policy/impl/ThreeFingerListener$Callbacks;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/policy/impl/PhoneWindowManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "ThreeFingerCallbacks"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;


# direct methods
.method constructor <init>(Lcom/android/internal/policy/impl/PhoneWindowManager;)V
    .locals 0
    .param p1, "this$0"    # Lcom/android/internal/policy/impl/PhoneWindowManager;

    .prologue
    .line 56
    iput-object p1, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$ThreeFingerCallbacks;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSwipeThreeFinger()V
    .locals 3

    .prologue
    iget-object v0, p0, Lcom/android/internal/policy/impl/PhoneWindowManager$ThreeFingerCallbacks;->this$0:Lcom/android/internal/policy/impl/PhoneWindowManager;

    iget-object v1, v0, Lcom/android/internal/policy/impl/PhoneWindowManager;->mHandler:Landroid/os/Handler;

    invoke-static {v0}, Lcom/android/internal/policy/impl/PhoneWindowManager;->access$2500(Lcom/android/internal/policy/impl/PhoneWindowManager;)Ljava/lang/Runnable;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
