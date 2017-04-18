From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Tue, 18 Apr 2017 17:40:34 +0900
Subject: [PATCH v3 1/3] dt-bindings: Add support for samsung s6e3hf2 panel
In-Reply-To: <1492504836-19225-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1492504836-19225-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170418084047epcas5p440464afa8770d07253f42f362764059b@epcas5p4.samsung.com>
Message-ID: <1492504836-19225-2-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The samsung s6e3hf2 panel is a 5.65" 1600x2560 AMOLED panel connected
using MIPI-DSI interfaces.

The s6e3hf2 is add to samsung,s6e3ha2.txt binding because it is a
panel similar to the s6e3ha2. So add the compatible string and
comments.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
index 18854f4..4acea25 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
@@ -1,7 +1,10 @@
 Samsung S6E3HA2 5.7" 1440x2560 AMOLED panel
+Samsung S6E3HF2 5.65" 1600x2560 AMOLED panel
 
 Required properties:
-  - compatible: "samsung,s6e3ha2"
+  - compatible: should be one of:
+    "samsung,s6e3ha2",
+    "samsung,s6e3hf2".
   - reg: the virtual channel number of a DSI peripheral
   - vdd3-supply: I/O voltage supply
   - vci-supply: voltage supply for analog circuits
-- 
1.9.1
