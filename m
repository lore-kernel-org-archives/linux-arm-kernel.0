From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 8 Mar 2013 19:30:45 +0530
Subject: [PATCH] ARM: DT: tegra20/tegra30: Correct clock id for UARTB
Message-ID: <1362751245-32432-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UARTB clock bit in CAR register is 7. Correcting this
in DTS file.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |    2 +-
 arch/arm/boot/dts/tegra30.dtsi |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index bbbe2de..b89fea2 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -260,7 +260,7 @@
 		reg-shift = <2>;
 		interrupts = <0 37 0x04>;
 		nvidia,dma-request-selector = <&apbdma 9>;
-		clocks = <&tegra_car 96>;
+		clocks = <&tegra_car 7>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index eddd0f9..0c9532b 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -247,7 +247,7 @@
 		reg-shift = <2>;
 		interrupts = <0 37 0x04>;
 		nvidia,dma-request-selector = <&apbdma 9>;
-		clocks = <&tegra_car 160>;
+		clocks = <&tegra_car 7>;
 		status = "disabled";
 	};
 
-- 
1.7.1.1
