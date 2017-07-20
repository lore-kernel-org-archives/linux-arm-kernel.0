From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 20 Jul 2017 14:29:00 +0200
Subject: [PATCH 2/3] ARM: shmobile: Document Renesas Draak board DT bindings
In-Reply-To: <1500553741-21890-1-git-send-email-geert+renesas@glider.be>
References: <1500553741-21890-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1500553741-21890-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 91f92d62650207fd..275cda1469b8b95c 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -55,6 +55,8 @@ Boards:
     compatible = "renesas,blanche", "renesas,r8a7792"
   - BOCK-W
     compatible = "renesas,bockw", "renesas,r8a7778"
+  - Draak (RTP0RC77995SEB0010S)
+    compatible = "renesas,draak", "renesas,r8a77995"
   - Genmai (RTK772100BC00000BR)
     compatible = "renesas,genmai", "renesas,r7s72100"
   - GR-Peach (X28A-M01-E/F)
-- 
2.7.4
