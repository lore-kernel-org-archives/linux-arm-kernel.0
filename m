From: sebastien.szymanski@armadeus.com (=?UTF-8?q?S=C3=A9bastien=20Szymanski?=)
Date: Tue, 22 May 2018 08:28:53 +0200
Subject: [PATCH v3 3/3] ARM: dts: imx6ull-colibri-wifi: remove operating points
In-Reply-To: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
Message-ID: <20180522062853.24799-3-sebastien.szymanski@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Operating points are now defined in the imx6ull.dtsi file so remove
them from board device trees.

Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
index 3dffbcd50bf6..183193e8580d 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
@@ -20,20 +20,6 @@
 
 &cpu0 {
 	clock-frequency = <792000000>;
-	operating-points = <
-		/* kHz	uV */
-		792000  1225000
-		528000	1175000
-		396000	1025000
-		198000	950000
-	>;
-	fsl,soc-operating-points = <
-		/* KHz	uV */
-		792000  1175000
-		528000	1175000
-		396000	1175000
-		198000	1175000
-	>;
 };
 
 &iomuxc {
-- 
2.16.1
