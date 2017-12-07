From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:38 +0100
Subject: [PATCH 35/54] arm64: dts: renesas: r8a7795-es1-salvator-x: Add SoC
 name to file header
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <aa8c6e451e96cb0db85e19d31da0b9bcc04e7217.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Document clearly which SoC this DTS applies to, to distinguish from
Salvator-X boards equipped with other SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
index 3f7d5f51e428..7f2a3d923f21 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
@@ -1,5 +1,5 @@
 /*
- * Device Tree Source for the Salvator-X board
+ * Device Tree Source for the Salvator-X board with R-Car H3 ES1.x
  *
  * Copyright (C) 2015 Renesas Electronics Corp.
  *
-- 
2.11.0
