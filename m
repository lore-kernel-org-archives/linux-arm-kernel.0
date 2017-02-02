From: mzoran@crowfest.net (Michael Zoran)
Date: Thu,  2 Feb 2017 01:05:36 -0800
Subject: [PATCH V2] Add devicetree for the Raspberry Pi 3, for arm (32)
Message-ID: <20170202090536.16724-1-mzoran@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Zoran <mzoran@crowfest.net>
---
 arch/arm/boot/dts/Makefile            | 3 ++-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-b.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8bd8878efe7b..72ba524df912 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -72,7 +72,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2835-rpi-b-plus.dtb \
 	bcm2835-rpi-a-plus.dtb \
 	bcm2836-rpi-2-b.dtb \
-	bcm2835-rpi-zero.dtb
+	bcm2835-rpi-zero.dtb \
+	bcm2837-rpi-3-b.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-asus-rt-ac56u.dtb \
 	bcm4708-asus-rt-ac68u.dtb \
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
new file mode 100644
index 000000000000..48ad20f83255
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -0,0 +1,2 @@
+#include "../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts"
+
-- 
2.11.0
