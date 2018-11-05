From: xiaowei.bao@nxp.com (Xiaowei Bao)
Date: Mon,  5 Nov 2018 16:46:49 +0800
Subject: [PATCHv2 2/6] ARM: dts: ls1021a: Add the status property disable PCIe
In-Reply-To: <20181105084653.26597-1-xiaowei.bao@nxp.com>
References: <20181105084653.26597-1-xiaowei.bao@nxp.com>
Message-ID: <20181105084653.26597-2-xiaowei.bao@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the status property disable the PCIe, the property will be enable
by bootloader.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v2:
 - no change

 arch/arm/boot/dts/ls1021a.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index bdd6e66..b769e0e 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -736,6 +736,7 @@
 					<0000 0 0 2 &gic GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		pcie at 3500000 {
@@ -759,6 +760,7 @@
 					<0000 0 0 2 &gic GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		can0: can at 2a70000 {
-- 
1.7.1
