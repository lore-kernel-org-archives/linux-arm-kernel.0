From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 9 Jul 2015 18:15:47 +0800
Subject: [PATCH 2/2] ARM: at91: sama5/dt: update rstc to correct compatible
 string
In-Reply-To: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1436436947-11210-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They'll use "atmel,sama5d3-rstc" for reset function.

Cc: devicetree at vger.kernel.org
Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 arch/arm/boot/dts/sama5d3.dtsi | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 9e2444b..280255b 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1259,7 +1259,7 @@
 			};
 
 			rstc at fffffe00 {
-				compatible = "atmel,at91sam9g45-rstc";
+				compatible = "atmel,sama5d3-rstc";
 				reg = <0xfffffe00 0x10>;
 			};
 
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 3ee22ee..481196c 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1277,7 +1277,7 @@
 			};
 
 			rstc at fc068600 {
-				compatible = "atmel,at91sam9g45-rstc";
+				compatible = "atmel,sama5d3-rstc";
 				reg = <0xfc068600 0x10>;
 			};
 
-- 
1.9.1
