From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 21 Apr 2016 14:58:41 +0900
Subject: [PATCH] arm64: dts: uniphier: use Daughter board on PH1-LD20
 reference board
Message-ID: <1461218321-16455-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include the development base board, which is equipped with some
devices such as EEPROM.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ph1-ld20-ref.dts  | 1 +
 arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi | 1 +
 2 files changed, 2 insertions(+)
 create mode 120000 arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20-ref.dts
index b0ed443..2adad8c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20-ref.dts
@@ -44,6 +44,7 @@
 
 /dts-v1/;
 /include/ "uniphier-ph1-ld20.dtsi"
+/include/ "uniphier-ref-daughter.dtsi"
 /include/ "uniphier-support-card.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi
new file mode 120000
index 0000000..4685a8d
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi
@@ -0,0 +1 @@
+../../../../arm/boot/dts/uniphier-ref-daughter.dtsi
\ No newline at end of file
-- 
1.9.1
