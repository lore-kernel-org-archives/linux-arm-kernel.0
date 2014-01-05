From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Jan 2014 19:13:47 +0100
Subject: [PATCH 5/5] ARM: sun7i: Add missing serial aliases
In-Reply-To: <1388945627-3432-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1388945627-3432-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1388945627-3432-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some UART aliases have been defined, but not all of them. Add the remaining
ones to be consistent and to ease the parsing of the DT by the bootloaders.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 119f066..b476855 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -18,6 +18,14 @@
 
 	aliases {
 		ethernet0 = &emac;
+		serial0 = &uart0;
+		serial1 = &uart1;
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
