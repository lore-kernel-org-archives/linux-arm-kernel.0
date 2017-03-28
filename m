From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 28 Mar 2017 13:42:57 +0100
Subject: [PATCH V3 5/6] arm64: tegra: Update the Tegra132 flowctrl compatible
 string
In-Reply-To: <1490704978-22906-1-git-send-email-jonathanh@nvidia.com>
References: <1490704978-22906-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1490704978-22906-6-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Tegra132 flowctrl compatible string to include
"nvidia,tegra132-flowctrl" so it is aligned with the flowctrl binding
documentation.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 3f3a46a4bd01..2b17936ac5be 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -224,7 +224,7 @@
 	};
 
 	flow-controller at 60007000 {
-		compatible = "nvidia,tegra124-flowctrl";
+		compatible = "nvidia,tegra132-flowctrl", "nvidia,tegra124-flowctrl";
 		reg = <0x0 0x60007000 0x0 0x1000>;
 	};
 
-- 
2.7.4
