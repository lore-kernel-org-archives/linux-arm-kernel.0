From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:24 +0900
Subject: [PATCH 3/9] ARM: shmobile: lager: add sound label on DTS
In-Reply-To: <cover.1437724902.git.horms+renesas@verge.net.au>
References: <cover.1437724902.git.horms+renesas@verge.net.au>
Message-ID: <30be0ba5f92c9a728bf3b3f41dbf3240eb3bbc11.1437724902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

It is easy to modify settings for Test or other purpose if sound has label

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 2eb8a995ae9f..5ae07a8385c5 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -174,7 +174,7 @@
 			  1800000 0>;
 	};
 
-	sound {
+	rsnd_ak4643: sound {
 		compatible = "simple-audio-card";
 
 		simple-audio-card,format = "left_j";
-- 
2.1.4
