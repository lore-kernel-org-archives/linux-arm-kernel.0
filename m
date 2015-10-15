From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 15:48:17 +0900
Subject: [PATCH v5 4/5] arm64: dts: r8a7795: enable nfs root on Salvator-X
 board
In-Reply-To: <1444891698-8780-1-git-send-email-horms+renesas@verge.net.au>
References: <1444891698-8780-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1444891698-8780-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As has been the practice for boards for 32bit ARM Renesas SoCs

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

--
v2
* No change

v3
* Added Ack

v4, v5
* No change
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 4fb120d8e7e8..d1c2fea8bebc 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -21,7 +21,7 @@
 	};
 
 	chosen {
-		bootargs = "ignore_loglevel";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = &scif2;
 	};
 
-- 
2.1.4
