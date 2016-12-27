From: Minghuan.Lian@nxp.com (Minghuan Lian)
Date: Tue, 27 Dec 2016 17:12:58 +0800
Subject: [PATCH 2/9] arm: dts: ls1021a: fix typo of MSI compatible string
In-Reply-To: <1482829985-24421-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1482829985-24421-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <1482829985-24421-2-git-send-email-Minghuan.Lian@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"1" should be replaced by "l". This is a typo.
The patch is to fix it.

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 282d854..6651938 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -122,14 +122,14 @@
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
1.9.1
