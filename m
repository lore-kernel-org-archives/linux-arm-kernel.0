From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Oct 2016 15:20:47 +0200
Subject: [PATCH 1/2] ARM: shmobile: r8a7794/alt: Add board part number to DT
 bindings
In-Reply-To: <1475587248-13670-1-git-send-email-geert+renesas@glider.be>
References: <1475587248-13670-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1475587248-13670-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 19f0a9e4302b508c..6c3ffc2ebeaa346a 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -35,7 +35,7 @@ SoCs:
 
 Boards:
 
-  - Alt
+  - Alt (RTP0RC7794SEB00010S)
     compatible = "renesas,alt", "renesas,r8a7794"
   - APE6-EVM
     compatible = "renesas,ape6evm", "renesas,r8a73a4"
-- 
1.9.1
