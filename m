From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 10 Nov 2014 10:32:24 +0900
Subject: [PATCH 7/8] ARM: shmobile: r8a73a4: fix scifb* naming
In-Reply-To: <cover.1415582842.git.horms+renesas@verge.net.au>
References: <cover.1415582842.git.horms+renesas@verge.net.au>
Message-ID: <0b3a0ef613538cae4b8b8f41315ef1fd3c957b12.1415582842.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Ports are named scifb0-3, not scifb2-5.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index c17afef..5c75c91 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -263,14 +263,14 @@
 		status = "disabled";
 	};
 
-	scifb2: serial at e6c20000 {
+	scifb0: serial at e6c20000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6c20000 0 0x100>;
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
 
-	scifb3: serial at e6c30000 {
+	scifb1: serial at e6c30000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6c30000 0 0x100>;
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
@@ -291,14 +291,14 @@
 		status = "disabled";
 	};
 
-	scifb4: serial at e6ce0000 {
+	scifb2: serial at e6ce0000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 0x100>;
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
 
-	scifb5: serial at e6cf0000 {
+	scifb3: serial at e6cf0000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6cf0000 0 0x100>;
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.1
