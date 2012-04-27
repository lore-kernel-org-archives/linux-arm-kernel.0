From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Apr 2012 13:46:16 -0600
Subject: [PATCH] ARM: dt: tegra trimslice: enable SDHCI1 controller
Message-ID: <1335555976-15130-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This is the micro-SD card slot.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-trimslice.dts |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index 0c1a54c..ead9365 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -296,10 +296,6 @@
 		status = "disable";
 	};
 
-	sdhci at c8000000 {
-		status = "disable";
-	};
-
 	sdhci at c8000200 {
 		status = "disable";
 	};
-- 
1.7.0.4
