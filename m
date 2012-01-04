From: swarren@nvidia.com (Stephen Warren)
Date: Wed,  4 Jan 2012 11:39:36 -0700
Subject: [PATCH 4/6] ARM: dt: tegra30.dtsi: Add extra GPIO interrupt
In-Reply-To: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
References: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
Message-ID: <1325702378-20863-4-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra30 GPIO controller has one more bank than Tegra20, and hence
has one more interrupt.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsi |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index e5d1406..2b3f6cd 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -61,7 +61,8 @@
 			       0 35 0x04
 			       0 55 0x04
 			       0 87 0x04
-			       0 89 0x04 >;
+			       0 89 0x04
+			       0 125 0x04 >;
 		#gpio-cells = <2>;
 		gpio-controller;
 	};
-- 
1.7.0.4
