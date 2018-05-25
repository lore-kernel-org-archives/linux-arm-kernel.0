From: lsun@mellanox.com (Liming Sun)
Date: Fri, 25 May 2018 12:06:58 -0400
Subject: [PATCH v1 4/4] MAINTAINERS: Add entry for Mellanox Bluefield Soc
In-Reply-To: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
Message-ID: <d6c68b8e28bcfbdb863355c3c4630070366f39b2.1527264077.git.lsun@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer information for Mellanox BlueField SoC.

Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58b9861..85d5639 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1636,6 +1636,14 @@ L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
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
