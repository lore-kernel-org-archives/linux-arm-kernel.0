From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 15 Dec 2015 09:33:20 +0100
Subject: [PATCH] arm64: perf: Correct Cortex-A53/A57 compatible values
Message-ID: <1450168400-462-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use commas instead of periods.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/pmu.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 97ba45af04fc693f..a6cd14888bed9b29 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -9,8 +9,8 @@ Required properties:
 - compatible : should be one of
 	"apm,potenza-pmu"
 	"arm,armv8-pmuv3"
-	"arm.cortex-a57-pmu"
-	"arm.cortex-a53-pmu"
+	"arm,cortex-a57-pmu"
+	"arm,cortex-a53-pmu"
 	"arm,cortex-a17-pmu"
 	"arm,cortex-a15-pmu"
 	"arm,cortex-a12-pmu"
-- 
1.9.1
