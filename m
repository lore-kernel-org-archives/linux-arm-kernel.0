From: matthias.bgg@kernel.org (matthias.bgg at kernel.org)
Date: Fri, 27 Apr 2018 11:24:02 +0200
Subject: [v3 10/10] MAINTAINERS: update Mediatek Soc entry
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
Message-ID: <d4283880be7689a83affbd8548a999731cb7c031.1524820923.git.mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

Mediatek SoCs include several soc specific drivers as well
as a mfd device. Add these to the maintainers file.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d5a621..74f7ea345096 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1621,6 +1621,8 @@ F:	arch/arm/boot/dts/mt7*
 F:	arch/arm/boot/dts/mt8*
 F:	arch/arm/mach-mediatek/
 F:	arch/arm64/boot/dts/mediatek/
+F:	drivers/soc/mediatek/
+F:	drivers/mfd/mtk-mmsys.c
 N:	mtk
 K:	mediatek
 
-- 
2.16.3
