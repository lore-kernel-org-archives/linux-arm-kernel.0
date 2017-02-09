From: juri.lelli@arm.com (Juri Lelli)
Date: Thu,  9 Feb 2017 09:25:17 +0000
Subject: [PATCH v2 1/9] Documentation: arm: fix wrong reference number in DT
 definition
In-Reply-To: <20170209092525.6654-1-juri.lelli@arm.com>
References: <20170209092525.6654-1-juri.lelli@arm.com>
Message-ID: <20170209092525.6654-2-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference to cpu capacity binding has a wrong number. Fix it.

Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index a1bcfeed5f24..c27376a27a92 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -246,7 +246,7 @@ nodes to be present and contain the properties described below.
 		Usage: Optional
 		Value type: <u32>
 		Definition:
-			# u32 value representing CPU capacity [3] in
+			# u32 value representing CPU capacity [4] in
 			  DMIPS/MHz, relative to highest capacity-dmips-mhz
 			  in the system.
 
@@ -473,5 +473,5 @@ cpus {
 [2] arm/msm/qcom,kpss-acc.txt
 [3] ARM Linux kernel documentation - idle states bindings
     Documentation/devicetree/bindings/arm/idle-states.txt
-[3] ARM Linux kernel documentation - cpu capacity bindings
+[4] ARM Linux kernel documentation - cpu capacity bindings
     Documentation/devicetree/bindings/arm/cpu-capacity.txt
-- 
2.10.0
