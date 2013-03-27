From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 27 Mar 2013 14:01:30 +0100
Subject: [PATCH v2 1/5] cpufreq: cpufreq-cpu0: Fix documentation example
In-Reply-To: <1364389294-1997-1-git-send-email-mpa@pengutronix.de>
References: <1364389294-1997-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1364389294-1997-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The example includes a property 'transition-latency', which should be
clock-latency.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
index 4416ccc..051f764 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
@@ -32,7 +32,7 @@ cpus {
 			396000  950000
 			198000  850000
 		>;
-		transition-latency = <61036>; /* two CLK32 periods */
+		clock-latency = <61036>; /* two CLK32 periods */
 	};
 
 	cpu at 1 {
-- 
1.8.1.5
