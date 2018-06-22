From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 22 Jun 2018 12:08:16 +0200
Subject: [PATCH v4] MAINTAINERS: Add file patterns for mediatek device tree
 bindings
Message-ID: <20180622100816.29320-1-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
v3:
  - Update for next-20180622,

v2:
  - Add Reviewed-by.

Impact on "scripts/get_maintainer.pl -f Documentation/devicetree/bindings/soc/mediatek/":

-Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:4/4=100%)
+Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC support)
+Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
-Matthias Brugger <matthias.bgg@gmail.com> (commit_signer:4/4=100%)
-Sean Wang <sean.wang@mediatek.com> (commit_signer:3/4=75%,authored:3/4=75%)
-Ulf Hansson <ulf.hansson@linaro.org> (commit_signer:2/4=50%)
-Chen Zhong <chen.zhong@mediatek.com> (commit_signer:1/4=25%)
-"weiyi.lu at mediatek.com" <weiyi.lu@mediatek.com> (authored:1/4=25%)
+linux-arm-kernel at lists.infradead.org (moderated list:ARM/Mediatek SoC support)
+linux-mediatek at lists.infradead.org (moderated list:ARM/Mediatek SoC support)
 devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 linux-kernel at vger.kernel.org (open list)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bb8ce891719ed21..baa4dc046daf9cdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1634,6 +1634,7 @@ M:	Matthias Brugger <matthias.bgg@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/soc/mediatek/
 F:	arch/arm/boot/dts/mt6*
 F:	arch/arm/boot/dts/mt7*
 F:	arch/arm/boot/dts/mt8*
-- 
2.17.1
