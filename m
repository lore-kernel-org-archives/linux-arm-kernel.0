From: blogic@openwrt.org (John Crispin)
Date: Fri, 26 Feb 2016 15:21:44 +0100
Subject: [PATCH V2 12/12] net-next: mediatek: add an entry to MAINTAINERS
In-Reply-To: <1456496504-50429-1-git-send-email-blogic@openwrt.org>
References: <1456496504-50429-1-git-send-email-blogic@openwrt.org>
Message-ID: <1456496504-50429-13-git-send-email-blogic@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself and Felix as the Maintainers for the driver.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 156e1d3..4a51c66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6908,6 +6908,13 @@ F:	include/uapi/linux/meye.h
 F:	include/uapi/linux/ivtv*
 F:	include/uapi/linux/uvcvideo.h
 
+MEDIATEK ETHERNET DRIVER
+M:	John Crispin <blogic@openwrt.org>
+M:	Felix Fietkau <nbd@openwrt.org>
+L:	netdev at vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/mediatek/
+
 MEDIATEK MT7601U WIRELESS LAN DRIVER
 M:	Jakub Kicinski <kubakici@wp.pl>
 L:	linux-wireless at vger.kernel.org
-- 
1.7.10.4
