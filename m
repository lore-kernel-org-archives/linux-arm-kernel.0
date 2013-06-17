From: tushar.behera@linaro.org (Tushar Behera)
Date: Mon, 17 Jun 2013 09:48:05 +0530
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable GPIO buttons driver
In-Reply-To: <1371442686-24999-1-git-send-email-tushar.behera@linaro.org>
References: <1371442686-24999-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1371442686-24999-2-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many of the boards use GPIO-mapped buttons for generic input.
For Arndale board, these buttons also serve as wakeup source.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/configs/exynos_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 227abf9..9ab979a 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -50,6 +50,7 @@ CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC75XX=y
 CONFIG_USB_NET_SMSC95XX=y
 CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_CROS_EC=y
 # CONFIG_MOUSE_PS2 is not set
 CONFIG_MOUSE_CYAPA=y
-- 
1.7.9.5
