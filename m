From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Wed, 5 Jul 2017 14:58:57 +0800
Subject: [PATCHv4 3/9] arm64: dts: ls1043a: fix typo of MSI compatible string
In-Reply-To: <1499237943-24203-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1499237943-24203-1-git-send-email-Zhiqiang.Hou@nxp.com>
Message-ID: <1499237943-24203-3-git-send-email-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Minghuan Lian <Minghuan.Lian@nxp.com>

"1" should be replaced by "l". This is a typo.
The patch is to fix it.

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
v4-v1:
 - None

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 31fd77f..7ff98f4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -653,21 +653,21 @@
 		};
 
 		msi1: msi-controller1 at 1571000 {
-			compatible = "fsl,1s1043a-msi";
+			compatible = "fsl,ls1043a-msi";
 			reg = <0x0 0x1571000 0x0 0x8>;
 			msi-controller;
 			interrupts = <0 116 0x4>;
 		};
 
 		msi2: msi-controller2 at 1572000 {
-			compatible = "fsl,1s1043a-msi";
+			compatible = "fsl,ls1043a-msi";
 			reg = <0x0 0x1572000 0x0 0x8>;
 			msi-controller;
 			interrupts = <0 126 0x4>;
 		};
 
 		msi3: msi-controller3 at 1573000 {
-			compatible = "fsl,1s1043a-msi";
+			compatible = "fsl,ls1043a-msi";
 			reg = <0x0 0x1573000 0x0 0x8>;
 			msi-controller;
 			interrupts = <0 160 0x4>;
-- 
2.1.0.27.g96db324
