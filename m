From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  9 Jan 2015 14:08:52 +0100
Subject: [PATCH 4/4] ARM: shmobile: kzm9g: Build DTS for Multiplatform
In-Reply-To: <1420808932-3899-1-git-send-email-geert+renesas@glider.be>
References: <1420808932-3899-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1420808932-3899-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Build the sh73a0 KZM9G board DTB in case of Multiplatform.
The DT reference case will be removed in the future and
can be ignored for now.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59e79e9167af28dd..52844bf64d22cc8c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -421,7 +421,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r8a7790-lager.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
-	r8a7794-alt.dtb
+	r8a7794-alt.dtb \
+	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_arria10_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
-- 
1.9.1
