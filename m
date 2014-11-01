From: dianders@chromium.org (Doug Anderson)
Date: Fri, 31 Oct 2014 20:52:57 -0700
Subject: [PATCH 1/2] regulator: Document binding for regulator suspend voltage
Message-ID: <1414813978-32233-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch builds upon (291d761 regulator: Document binding for
regulator suspend state for PM state) to allow setting the uV in
addition to the state at suspend time.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index aaad615..4e7ed76 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -28,6 +28,8 @@ Optional properties:
 - regulator-state-[mem/disk] node has following common properties:
 	- regulator-on-in-suspend: regulator should be on in suspend state.
 	- regulator-off-in-suspend: regulator should be off in suspend state.
+	- regulator-suspend-microvolt: regulator should be set to this voltage
+	  in suspend.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
-- 
2.1.0.rc2.206.gedb03e5
