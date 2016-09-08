From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Thu, 8 Sep 2016 21:09:06 +0800
Subject: [PATCH v6 6/6] media: mtk-mdp: add Maintainers entry for Mediatek MDP
 driver
In-Reply-To: <1473340146-6598-1-git-send-email-minghsiu.tsai@mediatek.com>
References: <1473340146-6598-1-git-send-email-minghsiu.tsai@mediatek.com>
Message-ID: <1473340146-6598-7-git-send-email-minghsiu.tsai@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Minghsiu Tsai, Houlong Wei and Andrew-CT Chen as
maintainers for Mediatek MDP driver

Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
Signed-off-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
---
 MAINTAINERS |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20bb1d0..e17e681 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7605,6 +7605,15 @@ L:	netdev at vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/mediatek/
 
+MEDIATEK MDP DRIVER
+M:	Minghsiu Tsai <minghsiu.tsai@mediatek.com>
+M:	Houlong Wei <houlong.wei@mediatek.com>
+M:	Andrew-CT Chen <andrew-ct.chen@mediatek.com>
+S:	Supported
+F:	drivers/media/platform/mtk-mdp/
+F:	drivers/media/platform/mtk-vpu/
+F:	Documentation/devicetree/bindings/media/mediatek-mdp.txt
+
 MEDIATEK MT7601U WIRELESS LAN DRIVER
 M:	Jakub Kicinski <kubakici@wp.pl>
 L:	linux-wireless at vger.kernel.org
-- 
1.7.9.5
