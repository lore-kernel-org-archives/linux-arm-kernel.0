From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 11 Apr 2018 16:53:54 +0800
Subject: [PATCH v2 01/12] dt-bindings: cpufreq: mediatek: use - instead of _
 in examples
In-Reply-To: <cover.1523434757.git.sean.wang@mediatek.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
Message-ID: <1b9604aa3d3c68be68caf8af32fa4130f57743d6.1523434758.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

It should be good that no use "_" is in examples. Consequently,
those nodes in certain files which have an inappropriate name containing
"_" are all being replaced with "-".

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm at vger.kernel.org
Cc: devicetree at vger.kernel.org
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
index d36f07e..38cfbb5 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
@@ -26,7 +26,7 @@ Optional properties:
 
 Example 1 (MT7623 SoC):
 
-	cpu_opp_table: opp_table {
+	cpu_opp_table: opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -86,7 +86,7 @@ Example 1 (MT7623 SoC):
 	};
 
 Example 2 (MT8173 SoC):
-	cpu_opp_table_a: opp_table_a {
+	cpu_opp_table_a: opp-table-a {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -131,7 +131,7 @@ Example 2 (MT8173 SoC):
 		};
 	};
 
-	cpu_opp_table_b: opp_table_b {
+	cpu_opp_table_b: opp-table-b {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-- 
2.7.4
