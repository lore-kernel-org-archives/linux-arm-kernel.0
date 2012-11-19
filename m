From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Nov 2012 15:34:44 -0700
Subject: [PATCH 2/2] ARM: tegra: seaboard: add missing DT vendor prefixes
In-Reply-To: <1353364484-5741-1-git-send-email-swarren@wwwdotorg.org>
References: <1353364484-5741-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1353364484-5741-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

A couple devices' DT compatible values only contained the device name
without any vendor prefix. Add the missing vendor prefixes.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-seaboard.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index eafeca6..4204598 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -492,12 +492,12 @@
 		};
 
 		temperature-sensor at 4c {
-			compatible = "nct1008";
+			compatible = "onnn,nct1008";
 			reg = <0x4c>;
 		};
 
 		magnetometer at c {
-			compatible = "ak8975";
+			compatible = "ak,ak8975";
 			reg = <0xc>;
 			interrupt-parent = <&gpio>;
 			interrupts = <109 0x04>; /* gpio PN5 */
-- 
1.7.10.4
