From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 20 Aug 2014 21:02:22 +0200
Subject: [PATCH] MAINTAINERS: add new Rockchip SoC list
Message-ID: <23904928.GAgx9QcSZa@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new list that Rockchip-specific patches should also be directed to.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Is this material for 3.17-rcX or should be queued for 3.18?

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aefa948..d7ca5cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1277,6 +1277,7 @@ F:	drivers/scsi/arm/
 ARM/Rockchip SoC support
 M:	Heiko Stuebner <heiko@sntech.de>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	linux-rockchip at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-rockchip/
 F:	drivers/*/*rockchip*
-- 
1.9.0
