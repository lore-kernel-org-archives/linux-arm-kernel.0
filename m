From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat, 13 May 2017 16:33:27 +0200
Subject: [PATCH v2 08/18] arm64: dts: meson-gxl-s905x: Comment typo fix
In-Reply-To: <20170513143337.14278-1-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
Message-ID: <20170513143337.14278-9-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2: Unchanged
 
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
index 0f78d836edaf..3314a0b3dad9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
@@ -48,7 +48,7 @@
 	compatible = "amlogic,s905x", "amlogic,meson-gxl";
 };
 
-/* S905X Only has access to its internal PHY */
+/* S905X only has access to its internal PHY */
 &ethmac {
 	phy-mode = "rmii";
 	phy-handle = <&internal_phy>;
-- 
2.12.0
