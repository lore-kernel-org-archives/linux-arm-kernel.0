From: stefan@agner.ch (Stefan Agner)
Date: Sun, 17 Dec 2017 21:37:19 +0100
Subject: [PATCH v2 5/9] ARM: dts: imx7-colibri: specify cpu-supply
In-Reply-To: <20171217203723.15896-1-stefan@agner.ch>
References: <20171217203723.15896-1-stefan@agner.ch>
Message-ID: <20171217203723.15896-5-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify CPU supply using the "cpu-supply" property instead of
the invalid "arm-supply" property.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index f61041af026a..6498c1136ef1 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -86,7 +86,7 @@
 };
 
 &cpu0 {
-	arm-supply = <&reg_DCDC2>;
+	cpu-supply = <&reg_DCDC2>;
 };
 
 &fec1 {
-- 
2.15.1
