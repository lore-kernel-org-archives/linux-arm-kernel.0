From: kraxel@redhat.com (Gerd Hoffmann)
Date: Tue,  7 Jun 2016 13:05:48 +0200
Subject: [PATCH v3 10/10] ARM: bcm2837: dt: Add the ethernet to the device
 trees
In-Reply-To: <1465297548-17182-1-git-send-email-kraxel@redhat.com>
References: <1465297548-17182-1-git-send-email-kraxel@redhat.com>
Message-ID: <1465297548-17182-11-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
index 223793d..6f47dd2 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 #include "bcm2837.dtsi"
 #include "../../../../arm/boot/dts/bcm2835-rpi.dtsi"
+#include "../../../../arm/boot/dts/bcm283x-rpi-smsc9514.dtsi"
 
 / {
 	compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
-- 
1.8.3.1
