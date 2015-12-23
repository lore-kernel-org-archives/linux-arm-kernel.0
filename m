From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 24 Dec 2015 00:23:40 +0900
Subject: [PATCH] ARM: dts: uniphier: fix a typo in comment block
Message-ID: <1450884220-8751-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi
index c6499ee..5321152 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi
@@ -53,7 +53,7 @@
 	compatible = "socionext,ph1-ld6b";
 };
 
-/* UART3 unavilable: the pads are not wired to the package balls */
+/* UART3 unavailable: the pads are not wired to the package balls */
 &serial3 {
 	status = "disabled";
 };
-- 
1.9.1
