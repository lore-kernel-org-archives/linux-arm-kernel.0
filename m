From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Wed,  3 Sep 2014 10:10:39 +0800
Subject: [PATCH v4 4/4] ARM: dts: enable Thermal on rk3288-evb board
In-Reply-To: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <1409710239-19941-5-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 2964370..fe85dde 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -101,6 +101,13 @@
 	status = "okay";
 };
 
+&tsadc {
+	passive-temp = <80>;
+	critical-temp = <100>;
+	force-shut-temp = <120>;
+	status = "okay";
+};
+
 &pinctrl {
 	buttons {
 		pwrbtn: pwrbtn {
-- 
1.9.1
