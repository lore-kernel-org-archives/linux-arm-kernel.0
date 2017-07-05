From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Wed, 5 Jul 2017 14:58:56 +0800
Subject: [PATCHv4 2/9] arm: dts: ls1021a: fix typo of MSI compatible string
In-Reply-To: <1499237943-24203-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1499237943-24203-1-git-send-email-Zhiqiang.Hou@nxp.com>
Message-ID: <1499237943-24203-2-git-send-email-Zhiqiang.Hou@nxp.com>
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

 arch/arm/boot/dts/ls1021a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 7bb9df2..51b0f69 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -129,14 +129,14 @@
 		};
 
 		msi1: msi-controller at 1570e00 {
-			compatible = "fsl,1s1021a-msi";
+			compatible = "fsl,ls1021a-msi";
 			reg = <0x0 0x1570e00 0x0 0x8>;
 			msi-controller;
 			interrupts =  <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		msi2: msi-controller at 1570e08 {
-			compatible = "fsl,1s1021a-msi";
+			compatible = "fsl,ls1021a-msi";
 			reg = <0x0 0x1570e08 0x0 0x8>;
 			msi-controller;
 			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.0.27.g96db324
