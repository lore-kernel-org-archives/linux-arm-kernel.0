From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat, 13 May 2017 16:33:25 +0200
Subject: [PATCH v2 06/18] arm64: dts: meson-gxl-s905x-khadas-vim: Fix Wifi
 node name
In-Reply-To: <20170513143337.14278-1-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
Message-ID: <20170513143337.14278-7-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcrmf -> brcmf -> wifi

Fixes: e15d2774b8c0 ("ARM64: dts: meson-gxl: add support for the Khadas VIM board")
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 3c8b0b51ef27..6a81f0168da5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -95,7 +95,7 @@
 };
 
 &sd_emmc_a {
-	brcmf: bcrmf at 1 {
+	brcmf: wifi at 1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 	};
-- 
2.12.0
