From: praithatha@nvidia.com (Pritesh Raithatha)
Date: Tue, 30 Oct 2012 15:37:09 +0530
Subject: [PATCH] arm: dt: tegra: fix length of pad control and mux registers
Message-ID: <1351591629-671-1-git-send-email-praithatha@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: <stable@vger.kernel.org>
Signed-off-by: Pritesh Raithatha <praithatha@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsi |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 3e4334d..3f96658 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -73,8 +73,8 @@
 
 	pinmux: pinmux {
 		compatible = "nvidia,tegra30-pinmux";
-		reg = <0x70000868 0xd0    /* Pad control registers */
-		       0x70003000 0x3e0>; /* Mux registers */
+		reg = <0x70000868 0xd4    /* Pad control registers */
+		       0x70003000 0x3e4>; /* Mux registers */
 	};
 
 	serial at 70006000 {
-- 
1.7.1
