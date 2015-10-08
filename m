From: linux.amoon@gmail.com (Anand Moon)
Date: Thu,  8 Oct 2015 03:48:37 +0000
Subject: [PATCHv3 2/2] ARM: multi_v7_defconfig: Enable rtl8152 ethernet driver
 for Odroid-XU4
In-Reply-To: <1444276117-3657-1-git-send-email-linux.amoon@gmail.com>
References: <1444276117-3657-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1444276117-3657-2-git-send-email-linux.amoon@gmail.com>
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
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 03deb7f..009d714 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -221,6 +221,7 @@ CONFIG_BROADCOM_PHY=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_MICREL_PHY=y
 CONFIG_USB_PEGASUS=y
+CONFIG_USB_RTL8152=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC75XX=y
 CONFIG_USB_NET_SMSC95XX=y
-- 
2.1.4
