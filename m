From: swarren@nvidia.com (Stephen Warren)
Date: Tue,  5 Jul 2011 14:23:28 -0600
Subject: [PATCH] ARM: tegra: Harmony: Use engineering names in DT compatible
	property
Message-ID: <1309897408-23085-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Engineering names are more stable than marketing names. Hence, use them
for Device Tree compatible properties instead.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Grant, this is against devicetree/arm, and only makes sense there; I'll
send a separate patch for the equivalent change in devicetree/test, since
the file is radically different there.

 arch/arm/boot/dts/tegra-harmony.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index 81032e7..4ad8ade 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -3,5 +3,5 @@
 
 / {
 	model = "NVIDIA Tegra2 Harmony evaluation board";
-	compatible = "nvidia,harmony", "nvidia,tegra250";
+	compatible = "nvidia,harmony", "nvidia,tegra20";
 };
-- 
1.7.0.4
