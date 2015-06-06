From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  6 Jun 2015 23:09:12 +0200
Subject: [PATCH 5/6] ARM: dts: pxa: fix power i2c definition
In-Reply-To: <1433624953-28165-1-git-send-email-robert.jarzmik@free.fr>
References: <1433624953-28165-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1433624953-28165-5-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the correct address and size to the device-tree description.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 9ebfd7f..94cf80f 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -59,6 +59,8 @@
 			reg = <0x40f00180 0x24>;
 			interrupts = <6>;
 			clocks = <&clks CLK_PWRI2C>;
+			#address-cells = <0x1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.1.4
