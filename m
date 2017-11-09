From: aparnab@ti.com (Aparna Balasubramanian)
Date: Thu, 9 Nov 2017 09:40:04 -0600
Subject: [PATCH] ARM: davinci_all_defconfig: enable support for USB network
 adaptors
In-Reply-To: <config_usb_usbnet>
References: <config_usb_usbnet>
Message-ID: <1510242004-18235-1-git-send-email-aparnab@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables CONFIG_USB_USBNET so that well known USB network adapters
can enumerate as network interfaces.

Signed-off-by: Aparna Balasubramanian <aparnab@ti.com>
---
 arch/arm/configs/davinci_all_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index bd0cf22..026154c 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -94,6 +94,7 @@ CONFIG_PPP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
+CONFIG_USB_USBNET=m
 CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_EVBUG=m
 CONFIG_KEYBOARD_ATKBD=m
-- 
1.7.9.5
