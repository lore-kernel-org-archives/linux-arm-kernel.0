From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  7 Dec 2013 12:26:34 +0400
Subject: [PATCH 3/5] ARM: dts: imx27-phytec-phycore-som: trivial: Typo fix
In-Reply-To: <1386404796-8848-1-git-send-email-shc_work@mail.ru>
References: <1386404796-8848-1-git-send-email-shc_work@mail.ru>
Message-ID: <1386404796-8848-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index 3435ce9..ce8d69a 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -180,7 +180,7 @@
 };
 
 &iomuxc {
-	imx27_phycard_s_som {
+	imx27_phycore_som {
 		pinctrl_fec1: fec1grp {
 			fsl,pins = <MX27_FEC1_PINGRP1>;
 		};
-- 
1.8.3.2
