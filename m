From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:16 +0900
Subject: [PATCH 42/69] ARM: shmobile: sh73a0: fixup sdhi compatible name
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <e8a8b8a3cd6e09209a9c253a22673836ef794f58.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

sh73a0 != r8a7740

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index aef8a61..29d2ee6 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -203,7 +203,7 @@
 	};
 
 	sdhi0: sd at ee100000 {
-		compatible = "renesas,sdhi-r8a7740";
+		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee100000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH
@@ -215,7 +215,7 @@
 
 	/* SDHI1 and SDHI2 have no CD pins, no need for CD IRQ */
 	sdhi1: sd@ee120000 {
-		compatible = "renesas,sdhi-r8a7740";
+		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee120000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH
@@ -226,7 +226,7 @@
 	};
 
 	sdhi2: sd@ee140000 {
-		compatible = "renesas,sdhi-r8a7740";
+		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee140000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH
-- 
1.8.4
