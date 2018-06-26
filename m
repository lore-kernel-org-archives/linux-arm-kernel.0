From: stefan@agner.ch (Stefan Agner)
Date: Tue, 26 Jun 2018 16:52:41 +0200
Subject: [PATCH 1/3] ARM: dts: imx6qdl-colibri: mux SD/MMC card detect
 explicitly
Message-ID: <20180626145243.24880-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not rely on reset/boot defaults and use a default GPIO setting
with pull-up enabled.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 76035db96f67..83d7c7d48c3f 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -567,7 +567,7 @@
 
 	pinctrl_mmc_cd: gpiommccd {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_D5__GPIO2_IO05	0x80000000
+			MX6QDL_PAD_NANDF_D5__GPIO2_IO05	0x1b0b1
 		>;
 	};
 
-- 
2.18.0
