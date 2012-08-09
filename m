From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 Aug 2012 16:57:06 +0100
Subject: [PATCH 1/1] ARM: ux500: Match Power-On-Key MFD and DTS compatible
 strings
Message-ID: <1344527828-6283-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible string found in the Power-On-Key's MFD cell matches
the device name provided in the driver. Keeping this naming convention
seems like a good idea, so we're changing the one found in the DTS
file to match.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 5106662..7d84f46 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -374,7 +374,7 @@
 				};
 
 				ab8500-ponkey {
-					compatible = "stericsson,ab8500-ponkey";
+					compatible = "stericsson,ab8500-poweron-key";
 					interrupts = <6 0x4
 						      7 0x4>;
 					interrupt-names = "ONKEY_DBF", "ONKEY_DBR";
-- 
1.7.9.5
