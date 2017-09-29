From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:12 +0200
Subject: [PATCH 03/22] arm64: dts: renesas: r8a77995: update PFC node name to
 pin-controller
In-Reply-To: <cover.1506678250.git.horms+renesas@verge.net.au>
References: <cover.1506678250.git.horms+renesas@verge.net.au>
Message-ID: <5a979972b6cb799944423f00c4e269d826c6d2c7.1506678250.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch changes the name from from e6060000.pfc and pfc at e6060000 to
e6060000.pin-controller and pin-controller at e6060000 like other Renesas
SoCs.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index d0f95b78c022..72c303362b16 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -122,7 +122,7 @@
 			reg = <0 0xe6160000 0 0x0200>;
 		};
 
-		pfc: pfc at e6060000 {
+		pfc: pin-controller at e6060000 {
 			compatible = "renesas,pfc-r8a77995";
 			reg = <0 0xe6060000 0 0x508>;
 		};
-- 
2.1.4
