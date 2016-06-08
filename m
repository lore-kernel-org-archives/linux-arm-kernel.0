From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Jun 2016 15:48:05 +0200
Subject: [RFC v4 6/7] ARM: exynos_defconfig: Enable EXTCON_USB_GPIO for Odroid
 XU3 USB OTG
In-Reply-To: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
References: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465393686-16644-7-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB 3.0 OTG requires working extcon for reporting VBUS/ID changes.
This is provided by extcon-usb-gpio driver.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index daf9762ec794..755c4de94eca 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -219,6 +219,7 @@ CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_MAX77802=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_EXTCON=y
+CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_MAX14577=y
 CONFIG_EXTCON_MAX77693=y
 CONFIG_EXTCON_MAX8997=y
-- 
1.9.1
