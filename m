From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 27 Jan 2016 15:11:52 -0600
Subject: [PATCH 04/13] dtb: amd: Fix typo in SPI device nodes
In-Reply-To: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1453929121-12171-5-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Remove invalid entry in the SPI device nodes.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index 5c73117..c7c759a 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -91,7 +91,6 @@
 		spi0: ssp at e1020000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
-			#gpio-cells = <2>;
 			reg = <0 0xe1020000 0 0x1000>;
 			spi-controller;
 			interrupts = <0 330 4>;
@@ -102,7 +101,6 @@
 		spi1: ssp at e1030000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
-			#gpio-cells = <2>;
 			reg = <0 0xe1030000 0 0x1000>;
 			spi-controller;
 			interrupts = <0 329 4>;
-- 
2.5.0
