From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:58:05 +0100
Subject: [PATCH 26/31] ARM: dts: lager: Drop superfluous status update for
 frequency override
In-Reply-To: <cover.1489999062.git.horms+renesas@verge.net.au>
References: <cover.1489999062.git.horms+renesas@verge.net.au>
Message-ID: <2507e3d41a3f0f09e7d756b34e3bb953d6d3b76d.1489999063.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The scif_clk device node is already enabled in r8a7790.dtsi, so there is
no need to update its status again.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index bd512c86e852..ba100a6f67ca 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -581,7 +581,6 @@
 
 &scif_clk {
 	clock-frequency = <14745600>;
-	status = "okay";
 };
 
 &msiof1 {
-- 
2.7.0.rc3.207.g0ac5344
