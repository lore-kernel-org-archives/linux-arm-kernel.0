From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 17 Oct 2012 21:10:44 +1300
Subject: [PATCH] ARM: multiplatform: Add a defconfig for multi_v5
Message-ID: <1350461444-22832-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a simple multi_v5_defconfig for arch-vt8500
multiplatform.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---

I expect there will be a bit of comment regarding this as others will
need to add their requirements as well, and it seems overly basic.

 arch/arm/configs/multi_v5_defconfig |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/arm/configs/multi_v5_defconfig

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
new file mode 100644
index 0000000..b4a36a7
--- /dev/null
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -0,0 +1,24 @@
+CONFIG_ARCH_MULTI_V7=n
+CONFIG_ARCH_MULTI_V5=y
+CONFIG_EXPERIMENTAL=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_ARCH_VT8500=y
+CONFIG_ARM_ARCH_TIMER=y
+CONFIG_AEABI=y
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_VFP=y
+CONFIG_NET=y
+CONFIG_SERIAL_VT8500=y
+CONFIG_SERIAL_VT8500_CONSOLE=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_VT8500=y
+CONFIG_FB=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FB_VT8500=y
+CONFIG_FB_WM8505=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_UHCI_HCD=y
+CONFIG_USB_UHCI_PLATFORM=y
+CONFIG_PWM_VT8500=y
+CONFIG_RTC_DRV_VT8500=y
-- 
1.7.9.5
