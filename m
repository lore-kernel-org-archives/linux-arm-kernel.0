From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 18 Mar 2015 13:45:37 +0800
Subject: [PATCH v2 3/3] MAINTAINERS: add Mediatek RTC driver
In-Reply-To: <1426657537-41414-1-git-send-email-eddie.huang@mediatek.com>
References: <1426657537-41414-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1426657537-41414-4-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Mediatek RTC driver to maintainer entry.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8c..ca27a69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1202,6 +1202,13 @@ W:	http://www.digriz.org.uk/ts78xx/kernel
 S:	Maintained
 F:	arch/arm/mach-orion5x/ts78xx-*
 
+ARM/Mediatek RTC DRIVER
+M:	Eddie Huang <eddie.huang@mediatek.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/rtc/rtc-mt*
+
 ARM/Mediatek SoC support
 M:	Matthias Brugger <matthias.bgg@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.8.1.1.dirty
