From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 13 Mar 2017 14:26:44 +0100
Subject: [PATCH 5/5] dt-bindings: clock: gxbb-clkc: Add GXL compatible variant
In-Reply-To: <1489411604-18700-1-git-send-email-narmstrong@baylibre.com>
References: <1489411604-18700-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1489411604-18700-6-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
index ce06435..a09d627 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
@@ -5,7 +5,8 @@ controllers within the SoC.
 
 Required Properties:
 
-- compatible: should be "amlogic,gxbb-clkc"
+- compatible: should be "amlogic,gxbb-clkc" for GXBB SoC,
+	      or "amlogic,gxl-clkc" for GXL and GXM SoC.
 - reg: physical base address of the clock controller and length of memory
        mapped region.
 
-- 
1.9.1
