From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 10:51:17 +0200
Subject: [PATCH v2 6/6] powerpc: dts: acadia: DT fix
 s/#interrupts-parent/#interrupt-parent/
In-Reply-To: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
References: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1477039877-20227-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
---
v2:
  - Add Acked-by.
---
 arch/powerpc/boot/dts/acadia.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/acadia.dts b/arch/powerpc/boot/dts/acadia.dts
index 57291f61ffe7021a..86266159521edac2 100644
--- a/arch/powerpc/boot/dts/acadia.dts
+++ b/arch/powerpc/boot/dts/acadia.dts
@@ -183,7 +183,7 @@
 			usb at ef603000 {
 				compatible = "ohci-be";
 				reg = <0xef603000 0x80>;
-				interrupts-parent = <&UIC0>;
+				interrupt-parent = <&UIC0>;
 				interrupts = <0xd 0x4 0xe 0x4>;
 			};
 
-- 
1.9.1
