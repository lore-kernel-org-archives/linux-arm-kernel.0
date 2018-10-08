From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Mon,  8 Oct 2018 11:14:27 +0800
Subject: [PATCH 3/4] dts/arm/ls1021a: Clean PCIe controller compatible strings
In-Reply-To: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181008031428.25293-4-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Removed the wrong compatible string "snps,dw-pcie", in case
match incorrect driver.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index f70025c2ab0f..13e91d577a26 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -716,7 +716,7 @@
 		};
 
 		pcie at 3400000 {
-			compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1021a-pcie";
 			reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
@@ -739,7 +739,7 @@
 		};
 
 		pcie at 3500000 {
-			compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
+			compatible = "fsl,ls1021a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00010000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-- 
2.17.1
