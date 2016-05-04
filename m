From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  4 May 2016 19:33:17 -0300
Subject: [PATCH v3 1/2] ARM: dts: imx6ul: Add SAI alias
Message-ID: <1462401198-931-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Add SAI alias entries, which makes it possibe for the SAI driver
to retrieve the port instance.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Newly introduced in this series.

 arch/arm/boot/dts/imx6ul.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 4356b65..6d1c317 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -36,6 +36,9 @@
 		serial5 = &uart6;
 		serial6 = &uart7;
 		serial7 = &uart8;
+		sai1 = &sai1;
+		sai2 = &sai2;
+		sai3 = &sai3;
 		spi0 = &ecspi1;
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
-- 
1.9.1
