From: linux.amoon@gmail.com (Anand Moon)
Date: Sun, 11 Oct 2015 17:35:59 +0000
Subject: [PATCHv4 1/2] ARM: exynos_defconfig: Enable rtl8152 ethernet driver
 for Odroid-XU4
Message-ID: <1444584960-2971-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Odroid XU4 has a RTL8153-CG gigabit Ethernet adapter, connected over
USB 3.0.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
Changes: Fixed the commit message thanks to Krzysztof Kozlowski
         Added reviewed by Krzysztof Kozlowski
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 1ff2bfa..5d1937b 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -61,6 +61,7 @@ CONFIG_BLK_DEV_DM=y
 CONFIG_DM_CRYPT=m
 CONFIG_NETDEVICES=y
 CONFIG_SMSC911X=y
+CONFIG_USB_RTL8152=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC75XX=y
 CONFIG_USB_NET_SMSC95XX=y
-- 
2.1.4
