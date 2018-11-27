From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:20 +0100
Subject: [PATCH 19/77] ARM: dts: sun5i: A10s: Remove empty SRAM node
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <3d53cccc472dc1f80a91f9055ab172a2e016c5c6.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SRAM node in the A10s DTSI is empty, remove it.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index d9fdcd41faa7..cd7119273b80 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -159,9 +159,6 @@
 	};
 };
 
-&sram_a {
-};
-
 &tcon0_out {
 	tcon0_out_hdmi: endpoint at 2 {
 		reg = <2>;
-- 
git-series 0.9.1
