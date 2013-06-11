From: matt.porter@linaro.org (Matt Porter)
Date: Tue, 11 Jun 2013 14:45:58 -0400
Subject: [PATCH] ARM: dts: bcm281xx: change comment to C89 style
Message-ID: <1370976358-18014-1-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CodingStyle does not allow C99 style comments. Since the
dts files live in the kernel for now, make this compliant.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
Acked-by: Christian Daudt <csd@broadcom.com>
---
 arch/arm/boot/dts/bcm11351.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 824bebe..0651a72 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -36,7 +36,7 @@
 
 	smc at 0x3404c000 {
 		compatible = "bcm,bcm11351-smc", "bcm,kona-smc";
-		reg = <0x3404c000 0x400>; //1 KiB in SRAM
+		reg = <0x3404c000 0x400>; /* 1 KiB in SRAM */
 	};
 
 	uart at 3e000000 {
-- 
1.7.9.5
