From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:25 +0900
Subject: [PATCH 4/9] ARM: shmobile: koelsch: add sound label on DTS
In-Reply-To: <cover.1437724902.git.horms+renesas@verge.net.au>
References: <cover.1437724902.git.horms+renesas@verge.net.au>
Message-ID: <18f88d22e4167a658091fe020beef723cefe86dd.1437724902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

It is easy to modify settings for Test or other purpose if sound has label

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index cffe33ff4d16..dc158845afdc 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -242,7 +242,7 @@
 			  1800000 0>;
 	};
 
-	sound {
+	rsnd_ak4643: sound {
 		compatible = "simple-audio-card";
 
 		simple-audio-card,format = "left_j";
-- 
2.1.4
