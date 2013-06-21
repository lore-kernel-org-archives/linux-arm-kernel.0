From: b32955@freescale.com (Huang Shijie)
Date: Fri, 21 Jun 2013 10:19:10 +0800
Subject: [PATCH v2 2/3] ARM: dts: imx6q: add a new pinctrl for ecspi1
In-Reply-To: <1371781151-20749-1-git-send-email-b32955@freescale.com>
References: <1371781151-20749-1-git-send-email-b32955@freescale.com>
Message-ID: <1371781151-20749-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new pinctrl is used by the imx6q-sabresd board.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index ba09dc3..9a69891 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -108,6 +108,14 @@
 							MX6Q_PAD_EIM_D16__ECSPI1_SCLK 0x100b1
 						>;
 					};
+
+					pinctrl_ecspi1_2: ecspi1grp-2 {
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
