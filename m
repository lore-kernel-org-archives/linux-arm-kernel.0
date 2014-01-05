From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Jan 2014 19:13:45 +0100
Subject: [PATCH 3/5] ARM: sun5i: a13: Add missing serial aliases
In-Reply-To: <1388945627-3432-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1388945627-3432-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1388945627-3432-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some UART aliases have been defined, but not all of them. Add the remaining
ones to be consistent and to ease the parsing of the DT by the bootloaders.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 320335a..15d66ac 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -16,6 +16,11 @@
 / {
 	interrupt-parent = <&intc>;
 
+	aliases {
+		serial1 = &uart1;
+		serial3 = &uart3;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.4.2
