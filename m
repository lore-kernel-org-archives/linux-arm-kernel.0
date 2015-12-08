From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  8 Dec 2015 18:54:06 +0100
Subject: [PATCH 01/13] ARM: shmobile: alt dts: Add serial port config to
 chosen/stdout-path
In-Reply-To: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
References: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1449597258-32623-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 767d9224d6cc5cc1..2394e4883786f13e 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -21,7 +21,7 @@
 
 	chosen {
 		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = &scif2;
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory at 40000000 {
-- 
1.9.1
