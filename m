From: stefan@agner.ch (stefan at agner.ch)
Date: Thu,  3 Apr 2014 17:47:09 +0200
Subject: [PATCH v2 1/2] of: add vendor prefix for Toradex AG
In-Reply-To: <cover.1396539657.git.stefan@agner.ch>
References: <cover.1396539657.git.stefan@agner.ch>
Message-ID: <395101baa8c0bc6bd30cd5c0c30b1e1bb738431b.1396539657.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch>

Adds toradex to the list of DT vendor prefixes.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index e9d19e2..a8d84f4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -89,6 +89,7 @@ ste	ST-Ericsson
 stericsson	ST-Ericsson
 ti	Texas Instruments
 tlm	Trusted Logic Mobility
+toradex	Toradex AG
 toshiba	Toshiba Corporation
 toumaz	Toumaz
 v3	V3 Semiconductor
-- 
1.9.1
