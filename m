From: lsun@mellanox.com (Liming Sun)
Date: Thu,  1 Nov 2018 12:25:33 -0400
Subject: [PATCH v6 4/9] MAINTAINERS: Add entry for Mellanox Bluefield Soc
In-Reply-To: <1541089538-175682-1-git-send-email-lsun@mellanox.com>
References: <1541089538-175682-1-git-send-email-lsun@mellanox.com>
Message-ID: <1541089538-175682-4-git-send-email-lsun@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer information for Mellanox BlueField SoC.

Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42a2f31..44fb693 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1694,6 +1694,14 @@ S:	Maintained
 F:	drivers/phy/mediatek/
 F:	Documentation/devicetree/bindings/phy/phy-mtk-*
 
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
