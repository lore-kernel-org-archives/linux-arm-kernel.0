From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:39 +0100
Subject: [PATCH 5/9] ARM: shmobile: r8a7794/alt: Add board part number to DT
 bindings
In-Reply-To: <cover.1478251657.git.horms+renesas@verge.net.au>
References: <cover.1478251657.git.horms+renesas@verge.net.au>
Message-ID: <d4a2c642ec968970fef015aa1f450b20cc37b67a.1478251657.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 785d1f847acb..106b542c27c9 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -37,7 +37,7 @@ SoCs:
 
 Boards:
 
-  - Alt
+  - Alt (RTP0RC7794SEB00010S)
     compatible = "renesas,alt", "renesas,r8a7794"
   - APE6-EVM
     compatible = "renesas,ape6evm", "renesas,r8a73a4"
-- 
2.7.0.rc3.207.g0ac5344
