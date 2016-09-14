From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 14 Sep 2016 14:27:57 +0100
Subject: [PATCH 19/19] reset: sti: softreset: Remove obsolete platforms from
 dt binding doc.
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1473859677-9231-20-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STiH415/6 SoC support is being removed from the kernel.
This patch updates the sti dt softreset bindings and
removes references to these obsolete platforms.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: <p.zabel@pengutronix.de>
---
 Documentation/devicetree/bindings/reset/st,sti-softreset.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/st,sti-softreset.txt b/Documentation/devicetree/bindings/reset/st,sti-softreset.txt
index 891a2fd..a21658f 100644
--- a/Documentation/devicetree/bindings/reset/st,sti-softreset.txt
+++ b/Documentation/devicetree/bindings/reset/st,sti-softreset.txt
@@ -15,15 +15,14 @@ Please refer to reset.txt in this directory for common reset
 controller binding usage.
 
 Required properties:
-- compatible: Should be "st,<chip>-softreset" example:
-	"st,stih415-softreset" or "st,stih416-softreset";
+- compatible: Should be st,stih407-softreset";
 - #reset-cells: 1, see below
 
 example:
 
 	softreset: softreset-controller {
 		#reset-cells = <1>;
-		compatible = "st,stih415-softreset";
+		compatible = "st,stih407-softreset";
 	};
 
 
@@ -42,5 +41,4 @@ example:
 
 Macro definitions for the supported reset channels can be found in:
 
-include/dt-bindings/reset/stih415-resets.h
-include/dt-bindings/reset/stih416-resets.h
+include/dt-bindings/reset/stih407-resets.h
-- 
1.9.1
