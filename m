From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 01 Oct 2015 02:01:38 +0300
Subject: [PATCH v2 1/2] ARM: shmobile: add Porter board DT bindings
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Message-ID: <1498934.YIZP7CvbA4@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Porter device tree bindings documentation, listing it as a supported board.
    
This allows to use checkpatch to validate DTSes referring to the Porter board.
 
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20150930-v4.3-rc3' tag of Simon
Horman's 'renesas.git' repo.

Changes in version 2:
- new patch.

 Documentation/devicetree/bindings/arm/shmobile.txt |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/Documentation/devicetree/bindings/arm/shmobile.txt
===================================================================
--- renesas.orig/Documentation/devicetree/bindings/arm/shmobile.txt
+++ renesas/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -55,5 +55,7 @@ Boards:
     compatible = "renesas,lager", "renesas,r8a7790"
   - Marzen
     compatible = "renesas,marzen", "renesas,r8a7779"
+  - Porter (M2-LCDP)
+    compatible = "renesas,porter", "renesas,r8a7791"
   - Silk
     compatible = "renesas,silk", "renesas,r8a7794";
