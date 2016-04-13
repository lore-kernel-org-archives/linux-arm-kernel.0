From: david@lechnology.com (David Lechner)
Date: Wed, 13 Apr 2016 17:30:28 -0500
Subject: [PATCH 3/3] ARM: DTS: da850: There are 101 interrupts.
In-Reply-To: <1460586628-25152-1-git-send-email-david@lechnology.com>
References: <1460586628-25152-1-git-send-email-david@lechnology.com>
Message-ID: <1460586628-25152-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix off by one error in da850 device tree.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 7f3fb98..2c60751 100644
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
