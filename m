From: blogic@openwrt.org (John Crispin)
Date: Tue,  8 Mar 2016 11:29:57 +0100
Subject: [PATCH V5 4/4] net-next: mediatek: add an entry to MAINTAINERS
In-Reply-To: <1457432997-25526-1-git-send-email-blogic@openwrt.org>
References: <1457432997-25526-1-git-send-email-blogic@openwrt.org>
Message-ID: <1457432997-25526-5-git-send-email-blogic@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself and Felix as the Maintainers for the MediaTek ethernet driver.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c4d157..b5293f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7012,6 +7012,13 @@ F:	include/uapi/linux/meye.h
 F:	include/uapi/linux/ivtv*
 F:	include/uapi/linux/uvcvideo.h
 
+MEDIATEK ETHERNET DRIVER
+M:	Felix Fietkau <nbd@openwrt.org>
+M:	John Crispin <blogic@openwrt.org>
+L:	netdev at vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/mediatek/
+
 MEDIATEK MT7601U WIRELESS LAN DRIVER
 M:	Jakub Kicinski <kubakici@wp.pl>
 L:	linux-wireless at vger.kernel.org
-- 
1.7.10.4
