From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Thu,  7 Jul 2016 12:09:30 +0530
Subject: [PATCH v4 5/5] ARM: dts: vfxxx: Add a compatible binding for Vybrid
 SoC bus driver
In-Reply-To: <cover.1467872014.git.maitysanchayan@gmail.com>
References: <cover.1467872014.git.maitysanchayan@gmail.com>
Message-ID: <c0e27f8b7a244ce81f1be03140f642a14b24b32d.1467872014.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a compatible binding to the main soc node required by the
Vybrid SoC bus driver to bind on.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 6c5222e..c68bc72 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -87,7 +87,7 @@
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "simple-bus";
+		compatible = "fsl,vf610-soc", "simple-bus";
 		interrupt-parent = <&mscm_ir>;
 		ranges;
 
-- 
2.9.0
