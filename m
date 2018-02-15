From: kbingham@kernel.org (Kieran Bingham)
Date: Thu, 15 Feb 2018 08:38:18 +0000
Subject: [PATCH 3/8] dt-bindings: display: renesas,
 lvds: Add LVDS binding for D3
In-Reply-To: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
Message-ID: <1518683903-10681-4-git-send-email-kbingham@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

The D3 supports two LVDS channels. Extend the binding to support them.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
index 79860f58a7ad..0dcf488b70df 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
@@ -14,6 +14,7 @@ Required properties:
 - compatible : Shall contain one of
   - "renesas,lvds-r8a7795" for R8A7795 (R-Car H3) compatible LVDS encoders
   - "renesas,lvds-r8a7796" for R8A7796 (R-Car M3-W) compatible LVDS encoders
+  - "renesas,lvds-r8a77995" for R8A77995 (R-Car D3) compatible LVDS encoders
 
 - reg: Base address and length for the memory-mapped registers
 - clocks: A phandle + clock-specifier pair for the functional clock
-- 
2.7.4
