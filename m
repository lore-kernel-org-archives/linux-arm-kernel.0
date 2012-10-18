From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 18 Oct 2012 16:26:34 +0530
Subject: [PATCH 4/5] ARM: tegra: dts: cardhu: enable SLINK4
In-Reply-To: <1350557795-31487-1-git-send-email-ldewangan@nvidia.com>
References: <1350557795-31487-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1350557795-31487-5-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SLINK4 in Tegra30 based platform Cardhu.
Setting maximum spi frequency to 25MHz.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra30-cardhu.dtsi |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index b245e6c..1bd73ea 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -275,6 +275,11 @@
 		};
 	};
 
+	slink at 7000da00 {
+		status = "okay";
+		spi-max-frequency = <25000000>;
+	};
+
 	ahub {
 		i2s at 70080400 {
 			status = "okay";
-- 
1.7.1.1
