From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon,  7 Aug 2017 12:52:38 +0530
Subject: [PATCH 06/10] ARM: dts: imx6q-apalis-ixora: get rid of obsolete
 fusion comment
In-Reply-To: <cover.1502087184.git.maitysanchayan@gmail.com>
References: <cover.1502087184.git.maitysanchayan@gmail.com>
Message-ID: <8281d802e666368f5de0f5c982a39019daecccd4.1502087184.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 arch/arm/boot/dts/imx6q-apalis-ixora.dts | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index a91043d5ac20..ebe5b909c6f9 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -271,10 +271,7 @@
 };
 
 &iomuxc {
-	/*
-	 * Mux the Apalis GPIOs
-	 * GPIO5, 6 used by optional fusion_F0710A kernel module
-	 */
+	/* Mux the Apalis GPIOs */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_apalis_gpio1 &pinctrl_apalis_gpio2
 		     &pinctrl_apalis_gpio3 &pinctrl_apalis_gpio4
-- 
2.13.3
