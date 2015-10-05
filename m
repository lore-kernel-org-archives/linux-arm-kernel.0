From: linux.amoon@gmail.com (Anand Moon)
Date: Mon,  5 Oct 2015 09:00:28 +0000
Subject: [PATCHv2 1/2] ARM: exynos_defconfig: Enable rtl8152 ethernet driver
 for Odroid-XU4
Message-ID: <1444035629-1173-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Odroid XU4 supports RTL8152/RTL8153 Based USB 3.0 Ethernet Adapters.
Support speed upto 10/100/1000 Mbit Ethernet LAN.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>

---
Changes: Fixed the commit log.
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
