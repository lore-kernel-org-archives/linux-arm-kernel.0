From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue,  5 Jun 2012 17:55:13 +0800
Subject: [PATCH 1/2] ARM: dts: update memory size on brownstone
Message-ID: <1338890114-22902-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory size on brownstone should be 128MB, not 64MB.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/boot/dts/mmp2-brownstone.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
index 153a4b2..c9b4f27 100644
--- a/arch/arm/boot/dts/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -11,7 +11,7 @@
 /include/ "mmp2.dtsi"
 
 / {
-	model = "Marvell MMP2 Aspenite Development Board";
+	model = "Marvell MMP2 Brownstone Development Board";
 	compatible = "mrvl,mmp2-brownstone", "mrvl,mmp2";
 
 	chosen {
@@ -19,7 +19,7 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x04000000>;
+		reg = <0x00000000 0x08000000>;
 	};
 
 	soc {
-- 
1.7.5.4
