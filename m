From: kraxel@redhat.com (Gerd Hoffmann)
Date: Thu, 19 Jan 2017 18:04:03 +0100
Subject: [RESENT PATCH] ARM: bcm2835: Add devicetree for the Raspberry Pi 3,
 for arm (32)
Message-ID: <1484845444-4617-1-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm/boot/dts/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7327250..82a760d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -70,7 +70,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2835-rpi-b-plus.dtb \
 	bcm2835-rpi-a-plus.dtb \
 	bcm2836-rpi-2-b.dtb \
-	bcm2835-rpi-zero.dtb
+	bcm2835-rpi-zero.dtb \
+	../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-asus-rt-ac56u.dtb \
 	bcm4708-asus-rt-ac68u.dtb \
-- 
1.8.3.1
