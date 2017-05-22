From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:58:39 +0200
Subject: [PATCH 06/35] arm64: dts: r8a7796: salvator-x: enable HS200 for eMMC
In-Reply-To: <cover.1495457812.git.horms+renesas@verge.net.au>
References: <cover.1495457812.git.horms+renesas@verge.net.au>
Message-ID: <3162ef76a8b6993f2941444cc5498c2660c55d79.1495457812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index c9f59b6ce33f..7f0ac6a9d49b 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -216,6 +216,7 @@
 	vmmc-supply = <&reg_3p3v>;
 	vqmmc-supply = <&reg_1p8v>;
 	bus-width = <8>;
+	mmc-hs200-1_8v;
 	non-removable;
 	status = "okay";
 };
-- 
2.1.4
