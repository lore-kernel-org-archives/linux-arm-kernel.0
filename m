From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 19 Jul 2013 14:58:37 +0100
Subject: [PATCH 06/22] ARM: ux500: Remove '0x's from BCM11351 DTS file
In-Reply-To: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
References: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1374242333-6852-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Christian Daudt <csd@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/bcm11351.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index c0cdf66..db5873a 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -34,7 +34,7 @@
 		      <0x3ff00100 0x100>;
 	};
 
-	smc at 0x3404c000 {
+	smc at 3404c000 {
 		compatible = "bcm,bcm11351-smc", "bcm,kona-smc";
 		reg = <0x3404c000 0x400>; /* 1 KiB in SRAM */
 	};
@@ -63,28 +63,28 @@
 		clock-frequency = <32768>;
 	};
 
-	sdio0: sdio at 0x3f180000 {
+	sdio0: sdio at 3f180000 {
 		compatible = "bcm,kona-sdhci";
 		reg = <0x3f180000 0x10000>;
 		interrupts = <0x0 77 0x4>;
 		status = "disabled";
 	};
 
-	sdio1: sdio at 0x3f190000 {
+	sdio1: sdio at 3f190000 {
 		compatible = "bcm,kona-sdhci";
 		reg = <0x3f190000 0x10000>;
 		interrupts = <0x0 76 0x4>;
 		status = "disabled";
 	};
 
-	sdio2: sdio at 0x3f1a0000 {
+	sdio2: sdio at 3f1a0000 {
 		compatible = "bcm,kona-sdhci";
 		reg = <0x3f1a0000 0x10000>;
 		interrupts = <0x0 74 0x4>;
 		status = "disabled";
 	};
 
-	sdio3: sdio at 0x3f1b0000 {
+	sdio3: sdio at 3f1b0000 {
 		compatible = "bcm,kona-sdhci";
 		reg = <0x3f1b0000 0x10000>;
 		interrupts = <0x0 73 0x4>;
-- 
1.8.1.2
