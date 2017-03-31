From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 31 Mar 2017 10:47:59 +0200
Subject: [PATCH 3/3] ARM64: dts: meson-gx: Add SoC info register
In-Reply-To: <1490950079-10145-1-git-send-email-narmstrong@baylibre.com>
References: <1490950079-10145-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1490950079-10145-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for the Amlogic Meson GX SoC information register.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 886efa5..c8e42d4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -357,6 +357,11 @@
 				#reset-cells = <1>;
 			};
 
+			chipid at 220 {
+				compatible = "amlogic,meson-gx-socinfo";
+				reg = <0x0 0x00220 0x0 0x4>;
+			};
+
 			uart_AO: serial at 4c0 {
 				compatible = "amlogic,meson-uart";
 				reg = <0x0 0x004c0 0x0 0x14>;
-- 
1.9.1
