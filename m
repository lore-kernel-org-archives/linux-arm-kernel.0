From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 03 Nov 2016 15:21:35 +0900
Subject: [PATCH 13/13] Documentation: synopsys-dw-mshc: remove the unused
 properties
In-Reply-To: <20161103062135.10697-1-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Message-ID: <20161103062135.10697-14-jh80.chung@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"support-highspeed" was the obsoleted property.
And "broken-cd" is not synopsys specific property.
It can be referred to mmc.txt binding Documentation.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 21c8251..3dd2849 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -68,11 +68,6 @@ Optional properties:
 * card-detect-delay: Delay in milli-seconds before detecting card after card
   insert event. The default value is 0.
 
-* supports-highspeed (DEPRECATED): Enables support for high speed cards (up to 50MHz)
-			   (use "cap-mmc-highspeed" or "cap-sd-highspeed" instead)
-
-* broken-cd: as documented in mmc core bindings.
-
 * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
   specified we'll defer probe until we can find this regulator.
 
-- 
2.10.1
