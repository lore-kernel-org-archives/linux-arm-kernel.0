From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 20 Jun 2018 15:28:26 +0300
Subject: [PATCH 1/2] dt-bindings: arm: Add compatible string for NVIDIA Carmel
Message-ID: <20180620122827.14165-1-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatibility string for the Carmel CPU in Tegra194.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 29e1dc5d506d..c4090c5a4f9f 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -183,6 +183,7 @@ described below.
 			    "marvell,sheeva-v5"
 			    "nvidia,tegra132-denver"
 			    "nvidia,tegra186-denver"
+			    "nvidia,tegra194-carmel"
 			    "qcom,krait"
 			    "qcom,kryo"
 			    "qcom,kryo385"
-- 
2.16.1
