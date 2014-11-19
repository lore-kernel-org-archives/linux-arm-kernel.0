From: smoch@web.de (Soeren Moch)
Date: Wed, 19 Nov 2014 07:54:49 +0100
Subject: [PATCH] ARM: dts: imx6q-tbs2910: Enable snvs-poweroff
Message-ID: <1416380089-6317-1-git-send-email-smoch@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables snvs-poweroff for TBS2910 boards.

Signed-off-by: Soeren Moch <smoch@web.de>
--
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/imx6q-tbs2910.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index d2a5743..7e7496c 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -208,6 +208,10 @@
 	status = "okay";
 };
 
+&snvs_poweroff {
+	status = "okay";
+};
+
 &spdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spdif>;
-- 
1.9.1
