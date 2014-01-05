From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Jan 2014 19:13:46 +0100
Subject: [PATCH 4/5] ARM: sun6i: Add missing serial aliases
In-Reply-To: <1388945627-3432-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1388945627-3432-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1388945627-3432-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some UART aliases have been defined, but not all of them. Add the remaining
ones to be consistent and to ease the parsing of the DT by the bootloaders.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 5256ad9..092bf97 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -16,6 +16,16 @@
 / {
 	interrupt-parent = <&gic>;
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+	};
+
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.4.2
