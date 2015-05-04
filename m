From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  4 May 2015 14:27:06 +0200
Subject: [PATCH v2 7/7] ARM: marvell/dt: add crypto node to kirkwood SoC
In-Reply-To: <1430742426-21202-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1430742426-21202-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1430742426-21202-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnaud Ebalard <arno@natisbad.org>

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/kirkwood.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 464f09a..1700b2b 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -41,7 +41,7 @@
 		pcie-io-aperture  = <0xf2000000 0x100000>;   /*   1 MiB    I/O space */
 
 		cesa: crypto at 0301 {
-			compatible = "marvell,orion-crypto";
+			compatible = "marvell,kirkwood-crypto";
 			reg = <MBUS_ID(0xf0, 0x01) 0x30000 0x10000>,
 			      <MBUS_ID(0x03, 0x01) 0 0x800>;
 			reg-names = "regs", "sram";
-- 
1.9.1
