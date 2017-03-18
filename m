From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Sat, 18 Mar 2017 08:55:09 +0100
Subject: [PATCH v3 5/5] ARM: dts: sun8i: Update audio-routing with renamed
 widgets
In-Reply-To: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
Message-ID: <20170318075509.3836-6-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The digital AIF interfaces has been renamed in the sun8i audio codec
driver so the audio-routing in the device tree must be renamed too.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 18c174fef84f..0467fb365bfc 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -113,8 +113,8 @@
 		simple-audio-card,mclk-fs = <512>;
 		simple-audio-card,aux-devs = <&codec_analog>;
 		simple-audio-card,routing =
-			"Left DAC", "Digital Left DAC",
-			"Right DAC", "Digital Right DAC";
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right";
 		status = "disabled";
 
 		simple-audio-card,cpu {
-- 
2.11.0
