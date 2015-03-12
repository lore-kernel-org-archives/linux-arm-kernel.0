From: vinceh@nvidia.com (Vince Hsu)
Date: Thu, 12 Mar 2015 20:15:12 +0800
Subject: [PATCH v2 11/17] ARM: tegra: add GPU power supply to Jetson TK1 DT
In-Reply-To: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Message-ID: <1426162518-7405-12-git-send-email-vinceh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power supply information which is board dependent for GK20A.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index dbfaba09703a..7558f9280646 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1682,6 +1682,10 @@
 		};
 	};
 
+	gpu-power-domain {
+		vdd-supply = <&vdd_gpu>;
+	};
+
 	/* Serial ATA */
 	sata at 0,70020000 {
 		status = "okay";
-- 
2.1.4
