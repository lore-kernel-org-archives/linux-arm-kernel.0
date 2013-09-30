From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 30 Sep 2013 13:00:24 +0900
Subject: [PATCH 5/5] ARM: shmobile: Remove #gpio-ranges-cells DT property
In-Reply-To: <cover.1380513421.git.horms+renesas@verge.net.au>
References: <cover.1380513421.git.horms+renesas@verge.net.au>
Message-ID: <3786f86b60833f32e3eeb016fcf8c324f8147e00.1380513421.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

This property is no longer required by the GPIO binding. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 1 -
 arch/arm/boot/dts/r8a7779.dtsi | 1 -
 arch/arm/boot/dts/r8a7790.dtsi | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 45ac404..3577aba 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -96,6 +96,5 @@
 	pfc: pfc at fffc0000 {
 		compatible = "renesas,pfc-r8a7778";
 		reg = <0xfffc000 0x118>;
-		#gpio-range-cells = <3>;
 	};
 };
diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 23a6244..ebbe507 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -188,7 +188,6 @@
 	pfc: pfc at fffc0000 {
 		compatible = "renesas,pfc-r8a7779";
 		reg = <0xfffc0000 0x23c>;
-		#gpio-range-cells = <3>;
 	};
 
 	thermal at ffc48000 {
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 885f9f4..413b4c2 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -148,7 +148,6 @@
 	pfc: pfc at e6060000 {
 		compatible = "renesas,pfc-r8a7790";
 		reg = <0 0xe6060000 0 0x250>;
-		#gpio-range-cells = <3>;
 	};
 
 	sdhi0: sdhi at ee100000 {
-- 
1.8.4
