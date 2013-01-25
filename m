From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:17:32 +0900
Subject: [PATCH 6/7] ARM: shmobile: Include DTSI of r8a7740 to armadillo800eva
In-Reply-To: <1359080253-30995-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080253-30995-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080253-30995-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index a7505a9..a8e7bd9 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "skeleton.dtsi"
+/include/ "r8a7740.dtsi"
 
 / {
 	model = "armadillo 800 eva";
-- 
1.7.10.4
