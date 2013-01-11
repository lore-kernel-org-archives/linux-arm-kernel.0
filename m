From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 11 Jan 2013 13:31:23 +0530
Subject: [PATCH v2 04/10] ARM: dt: tegra: paz00: add clock information
In-Reply-To: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
References: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1357891289-23500-4-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock i2c clock information to device node.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 arch/arm/boot/dts/tegra20-paz00.dts |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 6a93d14..a965fe9 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -266,6 +266,8 @@
 		clock-frequency = <80000>;
 		request-gpios = <&gpio 170 0>; /* gpio PV2 */
 		slave-addr = <138>;
+		clocks = <&tegra_car 67>, <&tegra_car 124>;
+		clock-names = "div-clk", "fast-clk";
 	};
 
 	i2c at 7000d000 {
-- 
1.7.4.1
