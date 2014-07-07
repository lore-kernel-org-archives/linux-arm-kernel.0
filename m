From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 08:47:37 +0200
Subject: [PATCH 2/3] ARM: shmobile: marzen: Consistently use tabs for
 indentation
In-Reply-To: <1404715658-31050-1-git-send-email-horms+renesas@verge.net.au>
References: <1404715658-31050-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404715658-31050-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unify white space usage by consistently using tabs for indentation.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 20b1768..5745555 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -112,17 +112,17 @@
 };
 
 &scif2 {
-       pinctrl-0 = <&scif2_pins>;
-       pinctrl-names = "default";
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
 
-       status = "okay";
+	status = "okay";
 };
 
 &scif4 {
-       pinctrl-0 = <&scif4_pins>;
-       pinctrl-names = "default";
+	pinctrl-0 = <&scif4_pins>;
+	pinctrl-names = "default";
 
-       status = "okay";
+	status = "okay";
 };
 
 &sdhi0 {
-- 
2.0.0.rc2
