From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:56 +0900
Subject: [PATCH 28/33] ARM: shmobile: r8a7790: add IIC0-2 clock macros
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <01d968e905968602c4958c416cfed7ad84b7489f.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/clock/r8a7790-clock.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 6548a5f..4d3e935 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -50,6 +50,7 @@
 #define R8A7790_CLK_SYS_DMAC0		19
 
 /* MSTP3 */
+#define R8A7790_CLK_IIC2		0
 #define R8A7790_CLK_TPU0		4
 #define R8A7790_CLK_MMCIF1		5
 #define R8A7790_CLK_SDHI3		11
@@ -57,6 +58,8 @@
 #define R8A7790_CLK_SDHI1		13
 #define R8A7790_CLK_SDHI0		14
 #define R8A7790_CLK_MMCIF0		15
+#define R8A7790_CLK_IIC0		18
+#define R8A7790_CLK_IIC1		23
 #define R8A7790_CLK_SSUSB		28
 #define R8A7790_CLK_CMT1		29
 #define R8A7790_CLK_USBDMAC0		30
-- 
1.8.5.2
