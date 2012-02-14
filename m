From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 14 Feb 2012 18:56:09 +0100
Subject: [PATCH v3 1/4] arm/dts: OMAP4: Update DTS file with new GIC bindings
In-Reply-To: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
References: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
Message-ID: <1329242172-4214-2-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC binding was updated in 3.2 and expects 3 interrupt-cells.
- Update the #interrupt-cells

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap4.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index e8fe75f..70a44f6 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -99,7 +99,7 @@
 		gic: interrupt-controller at 48241000 {
 			compatible = "arm,cortex-a9-gic";
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <3>;
 			reg = <0x48241000 0x1000>,
 			      <0x48240100 0x0100>;
 		};
-- 
1.7.0.4
