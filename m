From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Jun 2013 14:59:59 -0600
Subject: [PATCH 7/7] ARM: mxc: remove #gpio-ranges-cells property
In-Reply-To: <1371157199-7272-1-git-send-email-swarren@wwwdotorg.org>
References: <1371157199-7272-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1371157199-7272-7-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This property is no longer required by the GPIO binding. Remove it.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Assuming the previous patches are accepted, I assume this should be
applied or squashed into the branch where vf610.dtsi was added.
---
 arch/arm/boot/dts/vf610.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index e1eb7da..8577780 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -162,7 +162,6 @@
 			iomuxc: iomuxc at 40048000 {
 				compatible = "fsl,vf610-iomuxc";
 				reg = <0x40048000 0x1000>;
-				#gpio-range-cells = <3>;
 
 				/* functions and groups pins */
 
-- 
1.8.1.5
