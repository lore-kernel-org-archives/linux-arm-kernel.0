From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:46:47 +0900
Subject: [PATCH 5/6] ARM: shmobile: koelsch: Rename SCIF[01] serial ports to
 ttySC[01]
In-Reply-To: <cover.1419809774.git.horms+renesas@verge.net.au>
References: <cover.1419809774.git.horms+renesas@verge.net.au>
Message-ID: <1f75cdac773bc9c93ad6126c01ae27bd343302b1.1419809774.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

There's no reason to name the only two available serial ports on the
board ttySC6 and ttySC7 (apart from confusing userspace, which we should
try to avoid).

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 990af16..bf58c79 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -48,8 +48,8 @@
 	compatible = "renesas,koelsch", "renesas,r8a7791";
 
 	aliases {
-		serial6 = &scif0;
-		serial7 = &scif1;
+		serial0 = &scif0;
+		serial1 = &scif1;
 	};
 
 	chosen {
-- 
2.1.3
