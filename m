From: b32955@freescale.com (Huang Shijie)
Date: Thu, 20 Jun 2013 14:00:09 +0800
Subject: [PATCH 2/3] ARM: dts: imx6q: add a new pinctrl for ecspi1
In-Reply-To: <1371708010-22710-1-git-send-email-b32955@freescale.com>
References: <1371708010-22710-1-git-send-email-b32955@freescale.com>
Message-ID: <1371708010-22710-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new pinctrl is used by the imx6q-sabresd board.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index ba09dc3..0aa3451 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -108,6 +108,13 @@
 							MX6Q_PAD_EIM_D16__ECSPI1_SCLK 0x100b1
 						>;
 					};
+					pinctrl_ecspi1_2: ecspi1cr-1 {
+						fsl,pins = <
+							MX6Q_PAD_KEY_COL1__ECSPI1_MISO 0x100b1
+							MX6Q_PAD_KEY_ROW0__ECSPI1_MOSI 0x100b1
+							MX6Q_PAD_KEY_COL0__ECSPI1_SCLK 0x100b1
+						>;
+					};
 				};
 
 				ecspi3 {
-- 
1.7.1
