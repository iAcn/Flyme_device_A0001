.class public Lcom/android/internal/policy/impl/ThreeFingerListener;
.super Ljava/lang/Object;
.source "ThreeFingerListener.java"

# interfaces
.implements Landroid/view/WindowManagerPolicy$PointerEventListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/policy/impl/ThreeFingerListener$Callbacks;
    }
.end annotation


# static fields
.field private static final MAX_TRACKED_POINTERS:I = 0x20

.field private static final NUM_POINTER_SCREENSHOT:I = 0x3

.field private static final SWIPE_TIMEOUT_MS:J = 0x1f4L

.field private static final THREE_SWIPE_DISTANCE:I = 0x15e

.field private static final UNTRACKED_POINTER:I = -0x1


# instance fields
.field private final GESTURE_THREE_SWIPE_MASK:I

.field private final mCallbacks:Lcom/android/internal/policy/impl/ThreeFingerListener$Callbacks;

.field private final mDownPointerId:[I

.field private mDownPointers:I

.field private final mDownTime:[J

.field private final mDownX:[F

.field private final mDownY:[F

.field private mSwipeFireable:Z

.field private mSwipeMask:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/policy/impl/ThreeFingerListener$Callbacks;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "callbacks"    # Lcom/android/internal/policy/impl/ThreeFingerListener$Callbacks;

    .prologue
    const/16 v1, 0x20

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 13
    const/16 v0, 0xf

    iput v0, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->GESTURE_THREE_SWIPE_MASK:I

    .line 15
    new-array v0, v1, [I

    iput-object v0, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownPointerId:[I

    .line 16
    new-array v0, v1, [F

    iput-object v0, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownX:[F

    .line 17
    new-array v0, v1, [F

    iput-object v0, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownY:[F

    .line 18
    new-array v0, v1, [J

    iput-object v0, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownTime:[J

    .line 20
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mSwipeFireable:Z

    .line 21
    const/4 v0, 0x1

    iput v0, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mSwipeMask:I

    .line 24
    if-nez p2, :cond_0

    .line 25
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, " Callbacks must not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 27
    :cond_0
    iput-object p2, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mCallbacks:Lcom/android/internal/policy/impl/ThreeFingerListener$Callbacks;

    .line 29
    return-void
.end method

.method private captureDown(Landroid/view/MotionEvent;I)V
    .locals 6
    .param p1, "event"    # Landroid/view/MotionEvent;
    .param p2, "pointerIndex"    # I

    .prologue
    .line 62
    invoke-virtual {p1, p2}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    .line 63
    .local v2, "pointerId":I
    invoke-direct {p0, v2}, Lcom/android/internal/policy/impl/ThreeFingerListener;->findIndex(I)I

    move-result v0

    .line 64
    .local v0, "i":I
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v1

    .line 66
    .local v1, "pointerCount":I
    const/4 v3, -0x1

    if-eq v0, v3, :cond_0

    .line 67
    iget-object v3, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownX:[F

    invoke-virtual {p1, p2}, Landroid/view/MotionEvent;->getX(I)F

    move-result v4

    aput v4, v3, v0

    .line 68
    iget-object v3, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownY:[F

    invoke-virtual {p1, p2}, Landroid/view/MotionEvent;->getY(I)F

    move-result v4

    aput v4, v3, v0

    .line 69
    iget-object v3, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownTime:[J

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v4

    aput-wide v4, v3, v0

    .line 72
    :cond_0
    const/4 v3, 0x3

    if-ne v1, v3, :cond_1

    .line 73
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mSwipeFireable:Z

    .line 78
    :goto_0
    return-void

    .line 77
    :cond_1
    const/4 v3, 0x0

    iput-boolean v3, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mSwipeFireable:Z

    goto :goto_0
.end method

.method private detectSwipe(IJFF)V
    .locals 8
    .param p1, "i"    # I
    .param p2, "time"    # J
    .param p4, "x"    # F
    .param p5, "y"    # F

    .prologue
    .line 110
    iget-object v4, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownX:[F

    aget v2, v4, p1

    .line 111
    .local v2, "fromX":F
    iget-object v4, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownY:[F

    aget v3, v4, p1

    .line 112
    .local v3, "fromY":F
    iget-object v4, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownTime:[J

    aget-wide v4, v4, p1

    sub-long v0, p2, v4

    .line 114
    .local v0, "elapsed":J
    iget v4, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mSwipeMask:I

    const/16 v5, 0xf

    if-ge v4, v5, :cond_0

    const/high16 v4, 0x43af0000    # 350.0f

    add-float/2addr v4, v3

    cmpl-float v4, p5, v4

    if-lez v4, :cond_0

    const-wide/16 v4, 0x1f4

    cmp-long v4, v0, v4

    if-gez v4, :cond_0

    .line 115
    iget v4, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mSwipeMask:I

    const/4 v5, 0x1

    add-int/lit8 v6, p1, 0x1

    shl-int/2addr v5, v6

    or-int/2addr v4, v5

    iput v4, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mSwipeMask:I

    .line 117
    :cond_0
    return-void
.end method

.method private detectSwipe(Landroid/view/MotionEvent;)V
    .locals 9
    .param p1, "move"    # Landroid/view/MotionEvent;

    .prologue
    .line 96
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getHistorySize()I

    .line 97
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v7

    .line 99
    .local v7, "pointerCount":I
    const/4 v6, 0x0

    .local v6, "p":I
    :goto_0
    if-ge v6, v7, :cond_1

    .line 100
    invoke-virtual {p1, v6}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v8

    .line 101
    .local v8, "pointerId":I
    invoke-direct {p0, v8}, Lcom/android/internal/policy/impl/ThreeFingerListener;->findIndex(I)I

    move-result v1

    .line 103
    .local v1, "i":I
    const/4 v0, -0x1

    if-eq v1, v0, :cond_0

    .line 104
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v2

    invoke-virtual {p1, v6}, Landroid/view/MotionEvent;->getX(I)F

    move-result v4

    invoke-virtual {p1, v6}, Landroid/view/MotionEvent;->getY(I)F

    move-result v5

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/android/internal/policy/impl/ThreeFingerListener;->detectSwipe(IJFF)V

    .line 99
    :cond_0
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 107
    .end local v1    # "i":I
    .end local v8    # "pointerId":I
    :cond_1
    return-void
.end method

.method private findIndex(I)I
    .locals 4
    .param p1, "pointerId"    # I

    .prologue
    const/4 v1, -0x1

    .line 81
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v2, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownPointers:I

    if-ge v0, v2, :cond_1

    .line 82
    iget-object v2, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownPointerId:[I

    aget v2, v2, v0

    if-ne v2, p1, :cond_0

    .line 92
    .end local v0    # "i":I
    :goto_1
    return v0

    .line 81
    .restart local v0    # "i":I
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 87
    :cond_1
    iget v2, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownPointers:I

    const/16 v3, 0x20

    if-eq v2, v3, :cond_2

    if-ne p1, v1, :cond_3

    :cond_2
    move v0, v1

    .line 88
    goto :goto_1

    .line 91
    :cond_3
    iget-object v1, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownPointerId:[I

    iget v2, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownPointers:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownPointers:I

    aput p1, v1, v2

    .line 92
    iget v1, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownPointers:I

    add-int/lit8 v0, v1, -0x1

    goto :goto_1
.end method


# virtual methods
.method public onPointerEvent(Landroid/view/MotionEvent;)V
    .locals 3
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 33
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 59
    :cond_0
    :goto_0
    :pswitch_0
    return-void

    .line 35
    :pswitch_1
    iput-boolean v2, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mSwipeFireable:Z

    .line 36
    iput v1, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mDownPointers:I

    .line 37
    invoke-direct {p0, p1, v1}, Lcom/android/internal/policy/impl/ThreeFingerListener;->captureDown(Landroid/view/MotionEvent;I)V

    goto :goto_0

    .line 40
    :pswitch_2
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v0

    invoke-direct {p0, p1, v0}, Lcom/android/internal/policy/impl/ThreeFingerListener;->captureDown(Landroid/view/MotionEvent;I)V

    goto :goto_0

    .line 43
    :pswitch_3
    iget-boolean v0, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mSwipeFireable:Z

    if-eqz v0, :cond_0

    .line 44
    invoke-direct {p0, p1}, Lcom/android/internal/policy/impl/ThreeFingerListener;->detectSwipe(Landroid/view/MotionEvent;)V

    goto :goto_0

    .line 48
    :pswitch_4
    iget v0, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mSwipeMask:I

    const/16 v1, 0xf

    if-ne v0, v1, :cond_0

    .line 49
    iput v2, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mSwipeMask:I

    .line 50
    iget-object v0, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mCallbacks:Lcom/android/internal/policy/impl/ThreeFingerListener$Callbacks;

    invoke-interface {v0}, Lcom/android/internal/policy/impl/ThreeFingerListener$Callbacks;->onSwipeThreeFinger()V

    goto :goto_0

    .line 54
    :pswitch_5
    iput-boolean v1, p0, Lcom/android/internal/policy/impl/ThreeFingerListener;->mSwipeFireable:Z

    goto :goto_0

    .line 33
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_4
        :pswitch_3
        :pswitch_5
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method
