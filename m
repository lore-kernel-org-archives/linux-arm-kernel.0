From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Jan 2015 15:19:31 +0900
Subject: [PATCH 10/14 v2] ARM: shmobile: sh7372: Remove DT binding
 documentation
In-Reply-To: <20150126061747.6848.9708.sendpatchset@little-apple>
References: <20150126061747.6848.9708.sendpatchset@little-apple>
Message-ID: <20150126061931.6848.54934.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove DT compatible string documentation for the now removed sh7372 SoC.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 Changes since V1:
 - None

 Documentation/devicetree/bindings/arm/shmobile.txt |    2 --
 1 file changed, 2 deletions(-)

--- 0005/Documentation/devicetree/bindings/arm/shmobile.txt
+++ work/Documentation/devicetree/bindings/arm/shmobile.txt	2015-01-21 11:36:21.787569650 +0900
@@ -7,8 +7,6 @@ SoCs:
     compatible = "renesas,emev2"
   - RZ/A1H (R7S72100)
     compatible = "renesas,r7s72100"
-  - SH-Mobile AP4 (R8A73720/SH7372)
-    compatible = "renesas,sh7372"
   - SH-Mobile AG5 (R8A73A00/SH73A0)
     compatible = "renesas,sh73a0"
   - R-Mobile APE6 (R8A73A40)
