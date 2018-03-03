From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  3 Mar 2018 19:40:44 -0300
Subject: [PATCH v2 5/5] ARM: dts: vf610m4: Remove the zero length reg property
In-Reply-To: <1520116844-1145-1-git-send-email-festevam@gmail.com>
References: <1520116844-1145-1-git-send-email-festevam@gmail.com>
Message-ID: <1520116844-1145-5-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

All the vf610m4 based boards include the real memory size in their
dts files, so remove the the zero length reg property.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
Changes since v1:
- Improve the wording to "zero length reg property" (Stefan Agner)

 arch/arm/boot/dts/vf610m4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610m4.dtsi b/arch/arm/boot/dts/vf610m4.dtsi
index 5d52af2..8293276 100644
--- a/arch/arm/boot/dts/vf610m4.dtsi
+++ b/arch/arm/boot/dts/vf610m4.dtsi
@@ -50,7 +50,7 @@
 	#size-cells = <1>;
 	chosen { };
 	aliases { };
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 };
 
 &mscm_ir {
-- 
2.7.4
