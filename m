From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 17 Jan 2017 23:54:59 +0100
Subject: [PATCH 3/3] ARM64: dts: meson-gxm-rbox-pro: Add board compatible
 string
In-Reply-To: <20170117225459.4438-1-afaerber@suse.de>
References: <20170117030611.23827-2-afaerber@suse.de>
 <20170117225459.4438-1-afaerber@suse.de>
Message-ID: <20170117225459.4438-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: ada at kingnoval.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 To be squashed in v2.
 
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index 6ea225f584bd..7ff02754cfde 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -53,7 +53,7 @@
 #include "meson-gxm.dtsi"
 
 / {
-	compatible = "amlogic,s912", "amlogic,meson-gxm";
+	compatible = "kingnovel,r-box-pro", "amlogic,s912", "amlogic,meson-gxm";
 	model = "R-Box Pro";
 
 	aliases {
-- 
2.10.2
