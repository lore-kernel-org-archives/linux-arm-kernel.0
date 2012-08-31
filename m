From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Fri, 31 Aug 2012 18:06:12 +0200
Subject: [PATCH 2/2] ARM: omap/dts: update the documentation
In-Reply-To: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch>
References: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1346429172-5902-3-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Tobi/Overo board to the list of supported platforms.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 .../devicetree/bindings/arm/omap/omap.txt          |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index ccdd0e5..d0051a7 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -36,6 +36,9 @@ Boards:
 - OMAP3 BeagleBoard : Low cost community board
   compatible = "ti,omap3-beagle", "ti,omap3"
 
+- OMAP3 Tobi with Overo : Commercial expansion board with daughter board
+  compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3"
+
 - OMAP4 SDP : Software Developement Board
   compatible = "ti,omap4-sdp", "ti,omap4430"
 
-- 
1.7.5.4
