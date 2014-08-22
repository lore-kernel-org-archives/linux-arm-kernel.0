From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 22 Aug 2014 22:57:01 +0200
Subject: [PATCH 2/2] ARM: exynos_defconfig: enable USB gadget support
In-Reply-To: <1408741021-17759-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1408741021-17759-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1408741021-17759-3-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB gadget support without support for any specific gadgets to
more easily catch cases where a devices dts doesn't specify the usb
controllers dr_mode while it should.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index fc7d168..3664120 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -54,6 +54,7 @@ CONFIG_SMSC911X=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC75XX=y
 CONFIG_USB_NET_SMSC95XX=y
+CONFIG_USB_GADGET=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_CROS_EC=y
-- 
2.1.0
