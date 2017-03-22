From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 22 Mar 2017 11:32:27 +0100
Subject: [PATCH v2 5/5] dt-bindings: clock: gxbb-clkc: Add GXL compatible
 variant
In-Reply-To: <1490178747-14837-1-git-send-email-narmstrong@baylibre.com>
References: <1490178747-14837-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1490178747-14837-6-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Rob Herring <robh@kernel.org>
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
