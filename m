From: Minghuan.Lian@nxp.com (Minghuan Lian)
Date: Tue, 17 Jan 2017 17:32:37 +0800
Subject: [PATCH v3 3/9] arm64: dts: ls1043a: fix typo of MSI compatible string
In-Reply-To: <1484645563-29877-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1484645563-29877-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <1484645563-29877-4-git-send-email-Minghuan.Lian@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"1" should be replaced by "l". This is a typo.
The patch is to fix it.

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
v3-v1:
- None

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index ec13a6e..692fc35 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -589,21 +589,21 @@
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
1.9.1
