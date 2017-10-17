From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 17 Oct 2017 14:47:06 +0200
Subject: [PATCH v3 4/5] dt-bindings: interrupt-controller: Document RTD1195
In-Reply-To: <20171017124708.6242-1-afaerber@suse.de>
References: <20171017124708.6242-1-afaerber@suse.de>
Message-ID: <20171017124708.6242-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible strings for Realtek RTD1195.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3: New
 
 Could be squashed into 1/5 if acked.
 
 .../devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt
index f39ce341adbd..67be0653528b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd119x-mux.txt
@@ -4,6 +4,8 @@ Realtek RTD119x/129x IRQ Mux Controller
 Required properties:
 
 - compatible           :  Should be one of the following:
+                          - "realtek,rtd1195-misc-irq-mux"
+                          - "realtek,rtd1195-iso-irq-mux"
                           - "realtek,rtd1295-misc-irq-mux"
                           - "realtek,rtd1295-iso-irq-mux"
 - reg                  :  Specifies base physical address and size of the registers.
-- 
2.13.6
