From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun,  8 Jan 2017 14:31:00 +0100
Subject: [PATCH 4/4] MAINTAINERS: Extend ARM/Mediatek SoC support section
In-Reply-To: <20170108133100.10428-1-afaerber@suse.de>
References: <20170108133100.10428-1-afaerber@suse.de>
Message-ID: <20170108133100.10428-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catch mt7623 and arm64 dts subdirectory.

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a983a..7f5a629 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1522,8 +1522,10 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/mt6*
+F:	arch/arm/boot/dts/mt7*
 F:	arch/arm/boot/dts/mt8*
 F:	arch/arm/mach-mediatek/
+F:	arch/arm64/boot/dts/mediatek/
 N:	mtk
 K:	mediatek
 
-- 
2.10.2
