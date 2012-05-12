From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 May 2012 18:37:58 -0600
Subject: [PATCH 6/9] ARM: dt: tegra: remove duplicate device_type property
In-Reply-To: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
References: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1336783081-16978-7-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

It's already specified in skeleton.dtsi, included via tegra20.dtsi.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-seaboard.dts |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index ea93332..c935a28 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -7,7 +7,6 @@
 	compatible = "nvidia,seaboard", "nvidia,tegra20";
 
 	memory {
-		device_type = "memory";
 		reg = <0x00000000 0x40000000>;
 	};
 
-- 
1.7.0.4
