From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  8 Dec 2015 18:54:16 +0100
Subject: [PATCH 11/13] ARM: shmobile: marzen dts: Add serial port config to
 chosen/stdout-path
In-Reply-To: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
References: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1449597258-32623-12-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index fe396c8d58db7986..2193ba07d5334760 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -25,7 +25,7 @@
 
 	chosen {
 		bootargs = "ignore_loglevel root=/dev/nfs ip=on";
-		stdout-path = &scif2;
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
1.9.1
