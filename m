From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 26 Jul 2016 10:01:33 +0200
Subject: [PATCH 2/2] ARM: dts: alpine: remove 0x's from the node unit addresses
In-Reply-To: <20160726080133.31686-1-antoine.tenart@free-electrons.com>
References: <20160726080133.31686-1-antoine.tenart@free-electrons.com>
Message-ID: <20160726080133.31686-2-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove 0x's from the node unit addresses to be have consistent nodes.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/alpine.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index feb41cdafaea..d885ceb08f2a 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -129,7 +129,7 @@
 			reg-io-width = <4>;
 		};
 
-		uart1:uart at 0xfd884000 {
+		uart1:uart at fd884000 {
 			compatible = "ns16550a";
 			reg = <0x0 0xfd884000 0x0 0x1000>;
 			clock-frequency = <375000000>;
@@ -139,7 +139,7 @@
 		};
 
 		/* Internal PCIe Controller */
-		pcie-internal at 0xfbc00000 {
+		pcie-internal at fbc00000 {
 			compatible = "pci-host-ecam-generic";
 			device_type = "pci";
 			#size-cells = <2>;
-- 
2.9.2
