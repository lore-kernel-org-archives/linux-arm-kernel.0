From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 25 Oct 2018 13:57:51 +0530
Subject: [PATCH] dt-bindings: arm: Fix cpu capacity mismatch in example
Message-ID: <138600f5d504b41202a29a1e130a7aa4e51f1925.1540451976.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The example text says the capacity value should be 446, while the
example have it set to 578 instead. Fix the mismatch.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpu-capacity.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
index 9b5685a1d15d..7a0d6b429c8d 100644
--- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
+++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
@@ -61,7 +61,7 @@ mhz values (normalized w.r.t. the highest value found while parsing the DT).
 Example 1 (ARM 64-bit, 6-cpu system, two clusters):
 capacities-dmips-mhz are scaled w.r.t. 1024 (cpu at 0 and cpu at 1)
 supposing cluster0 at max-freq=1100 and custer1 at max-freq=850,
-final capacities are 1024 for cluster0 and 446 for cluster1
+final capacities are 1024 for cluster0 and 578 for cluster1
 
 cpus {
 	#address-cells = <2>;
-- 
2.19.1.568.g152ad8e3369a
