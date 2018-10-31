From: lsun@mellanox.com (Liming Sun)
Date: Wed, 31 Oct 2018 14:09:56 -0400
Subject: [PATCH v5 4/5] MAINTAINERS: Add entry for Mellanox Bluefield Soc
In-Reply-To: <1541009397-76223-1-git-send-email-lsun@mellanox.com>
References: <1541009397-76223-1-git-send-email-lsun@mellanox.com>
Message-ID: <1541009397-76223-4-git-send-email-lsun@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer information for Mellanox BlueField SoC.

Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c78feb0..07f7c7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1649,6 +1649,14 @@ L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/phy/mediatek/phy-mtk-tphy.c
 
+ARM/Mellanox BlueField SoC support
+M:	David Woods <dwoods@mellanox.com>
+M:	Liming Sun <lsun@mellanox.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/soc/mellanox/*
+F:	Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt
+
 ARM/MICREL KS8695 ARCHITECTURE
 M:	Greg Ungerer <gerg@uclinux.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.8.3.1
