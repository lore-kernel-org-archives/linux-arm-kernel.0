From: mniewoeh@stud.hs-offenburg.de (=?iso-8859-1?Q?Michael_Niew=F6hner?=)
Date: Mon, 11 May 2015 22:57:21 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: add system-power-controller to act8846
Message-ID: <64DE272A-FD25-406C-A51B-6C5B76DA5171@stud.hs-offenburg.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add system-power-controller to act8846 in rk3188-radxarock.dts in addition to
the act8846 patch fixing the reboot kernel panic

Signed-off-by: Michael Niewoehner <mniewoeh@stud.hs-offenburg.de>
---
 arch/arm/boot/dts/rk3188-radxarock.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index bdf8570..225a0eb 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -152,6 +152,7 @@
 		compatible = "active-semi,act8846";
 		reg = <0x5a>;
 		status = "okay";
+		system-power-controller;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&act8846_dvs0_ctl>;
-- 
2.3.5
