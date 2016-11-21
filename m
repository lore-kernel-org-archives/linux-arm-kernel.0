From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 21 Nov 2016 13:05:34 +0100
Subject: [PATCH 05/18] arm64: dts: h3ulcb: update header
In-Reply-To: <cover.1479726397.git.horms+renesas@verge.net.au>
References: <cover.1479726397.git.horms+renesas@verge.net.au>
Message-ID: <c77c97557614f07c72393eafa09ef826e0924293.1479726397.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

This updates H3ULCB device tree header with official board name

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
index bcb11a868343..f178fe1730de 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
@@ -1,5 +1,5 @@
 /*
- * Device Tree Source for the H3ULCB board
+ * Device Tree Source for the H3ULCB (R-Car Starter Kit Premier) board
  *
  * Copyright (C) 2016 Renesas Electronics Corp.
  * Copyright (C) 2016 Cogent Embedded, Inc.
-- 
2.7.0.rc3.207.g0ac5344
