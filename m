From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 19 Feb 2018 09:56:45 +0200
Subject: [PATCH 2/2] ARM: dts: hummingboard: Remove mention of nonexistent node
In-Reply-To: <535f327ebffa93ee780381e6c9f9f39b7c6d1a26.1519027005.git.baruch@tkos.co.il>
References: <535f327ebffa93ee780381e6c9f9f39b7c6d1a26.1519027005.git.baruch@tkos.co.il>
Message-ID: <d7edf747a7e4f94488d7f2430fcd2cd660a6123d.1519027005.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no pinctrl_usbotg_2 node in current Hummingboard dts files.
Drop reference to that.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi  | 3 +--
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index e59b1aeba1d7..d1f8fd708e13 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -239,8 +239,7 @@
 
 		pinctrl_hummingboard_usbotg_id: hummingboard-usbotg-id {
 			/*
-			 * Similar to pinctrl_usbotg_2, but we want it
-			 * pulled down for a fixed host connection.
+			 * We want it pulled down for a fixed host connection.
 			 */
 			fsl,pins = <MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x13059>;
 		};
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index dffbc92e0023..194d152d8f4b 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -409,8 +409,7 @@
 
 		pinctrl_hummingboard2_usbotg_id: hummingboard2-usbotg-id {
 			/*
-			 * Similar to pinctrl_usbotg_2, but we want it
-			 * pulled down for a fixed host connection.
+			 * We want it pulled down for a fixed host connection.
 			 */
 			fsl,pins = <MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x13059>;
 		};
-- 
2.16.1
