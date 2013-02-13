From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Feb 2013 14:33:13 -0700
Subject: [PATCH 4/9] ARM: tegra: device tree whitespace cleanup
In-Reply-To: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1360791198-29462-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Remove white-space from empty line; triggers checkpatch.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index cdb8da0..f3c7681 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -207,7 +207,7 @@
 		compatible = "nvidia,tegra20-das";
 		reg = <0x70000c00 0x80>;
 	};
-	
+
 	tegra_ac97: ac97 {
 		compatible = "nvidia,tegra20-ac97";
 		reg = <0x70002000 0x200>;
-- 
1.7.10.4
