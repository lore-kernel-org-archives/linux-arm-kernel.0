From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Tue, 26 Sep 2017 00:19:07 +0530
Subject: [PATCH] ARM: dts: rk3288-vyasa: Enable mali GPU node
Message-ID: <1506365347-18655-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Enable mali GPU node for rk3288 vyasa board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vyasa.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index 156193b..932311c 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -82,6 +82,11 @@
 	cpu0-supply = <&vdd_cpu>;
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &hdmi {
 	ddc-i2c-bus = <&i2c2>;
 	status = "okay";
-- 
2.7.4
