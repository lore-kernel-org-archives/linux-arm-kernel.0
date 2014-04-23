From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:45 +0900
Subject: [PATCH 17/33] ARM: shmobile: r8a7791: add IIC0/1 clock macros
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <c6e8f325e769aabd059f8ff7d29e406345f83929.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/clock/r8a7791-clock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index 30f82f2..2df1a11f 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -51,6 +51,8 @@
 #define R8A7791_CLK_SDHI1		12
 #define R8A7791_CLK_SDHI0		14
 #define R8A7791_CLK_MMCIF0		15
+#define R8A7791_CLK_IIC0		18
+#define R8A7791_CLK_IIC1		23
 #define R8A7791_CLK_SSUSB		28
 #define R8A7791_CLK_CMT1		29
 #define R8A7791_CLK_USBDMAC0		30
-- 
1.8.5.2
