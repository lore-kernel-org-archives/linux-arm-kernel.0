From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  7 May 2018 09:02:44 -0300
Subject: [PATCH] arm64: dts: fsl-ls1012a: Fix DTC aliases warnings
Message-ID: <1525694564-15203-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Use '-' instead of '_' to fix the following DTC warnings with W=1:

arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'

Cc: Harninder Rai <harninder.rai@nxp.com>
Cc: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index bb788ed..205f0f4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -53,11 +53,11 @@
 
 	aliases {
 		crypto = &crypto;
-		rtic_a = &rtic_a;
-		rtic_b = &rtic_b;
-		rtic_c = &rtic_c;
-		rtic_d = &rtic_d;
-		sec_mon = &sec_mon;
+		rtic-a = &rtic_a;
+		rtic-b = &rtic_b;
+		rtic-c = &rtic_c;
+		rtic-d = &rtic_d;
+		sec-mon = &sec_mon;
 	};
 
 	cpus {
-- 
2.7.4
