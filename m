From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Jan 2014 19:13:44 +0100
Subject: [PATCH 2/5] ARM: sun5i: a10s: Add missing serial aliases
In-Reply-To: <1388945627-3432-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1388945627-3432-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1388945627-3432-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some UART aliases have been defined, but not all of them. Add the remaining
ones to be consistent and to ease the parsing of the DT by the bootloaders.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index ea16054..2318082 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -18,6 +18,10 @@
 
 	aliases {
 		ethernet0 = &emac;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
 	};
 
 	cpus {
-- 
1.8.4.2
