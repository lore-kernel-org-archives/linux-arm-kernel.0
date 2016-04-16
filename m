From: david@lechnology.com (David Lechner)
Date: Sat, 16 Apr 2016 12:00:20 -0500
Subject: [PATCH v2 4/4] ARM: davinci: da850: There are 101 interrupts.
In-Reply-To: <1460826020-1256-1-git-send-email-david@lechnology.com>
References: <1460826020-1256-1-git-send-email-david@lechnology.com>
Message-ID: <1460826020-1256-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix off by one error in da850 device tree.

Signed-off-by: David Lechner <david@lechnology.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---

no change

 arch/arm/boot/dts/da850.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 26fc0812..cf1aad8 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -19,7 +19,7 @@
 			compatible = "ti,cp-intc";
 			interrupt-controller;
 			#interrupt-cells = <1>;
-			ti,intc-size = <100>;
+			ti,intc-size = <101>;
 			reg = <0xfffee000 0x2000>;
 		};
 	};
-- 
1.9.1
