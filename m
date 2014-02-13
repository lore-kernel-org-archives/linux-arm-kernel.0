From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu, 13 Feb 2014 11:25:16 +0100
Subject: [PATCH v2 4/4] Documentation: dt: OMAP: Update Overo/Tobi
In-Reply-To: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
References: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1392287116-4548-5-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the compatible string for Overo/Tobi to reflect the latest
changes.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 34dc40c..af9b4a0 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -91,7 +91,7 @@ Boards:
   compatible = "ti,omap3-beagle", "ti,omap3"
 
 - OMAP3 Tobi with Overo : Commercial expansion board with daughter board
-  compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3"
+  compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3"
 
 - OMAP4 SDP : Software Development Board
   compatible = "ti,omap4-sdp", "ti,omap4430"
-- 
1.8.1.2
