From: kraxel@redhat.com (Gerd Hoffmann)
Date: Tue,  7 Jun 2016 13:05:46 +0200
Subject: [PATCH v3 08/10] ARM: bcm2835: Add devicetree for the Raspberry Pi 3,
 for arm (32)
In-Reply-To: <1465297548-17182-1-git-send-email-kraxel@redhat.com>
References: <1465297548-17182-1-git-send-email-kraxel@redhat.com>
Message-ID: <1465297548-17182-9-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm/boot/dts/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 06b6c2d..71e2d36 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -66,7 +66,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2835-rpi-b-rev2.dtb \
 	bcm2835-rpi-b-plus.dtb \
 	bcm2835-rpi-a-plus.dtb \
-	bcm2836-rpi-2-b.dtb
+	bcm2836-rpi-2-b.dtb \
+	../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-asus-rt-ac56u.dtb \
 	bcm4708-asus-rt-ac68u.dtb \
-- 
1.8.3.1
