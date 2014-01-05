From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Jan 2014 19:13:43 +0100
Subject: [PATCH 1/5] ARM: sun4i: a10: Add missing serial aliases
Message-ID: <1388945627-3432-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some UART aliases have been defined, but not all of them. Add the remaining
ones to be consistent and to ease the parsing of the DT by the bootloaders.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 040bb0e..28273f9 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -19,6 +19,12 @@
 		ethernet0 = &emac;
 		serial0 = &uart0;
 		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
 	};
 
 	cpus {
-- 
1.8.4.2
