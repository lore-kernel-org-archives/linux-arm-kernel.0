From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 27 Apr 2016 02:55:18 +0300
Subject: [PATCH 2/3] MAINTAINERS: add new maintainers of NXP LPC32xx SoC
In-Reply-To: <1461714919-25577-1-git-send-email-vz@mleia.com>
References: <1461714919-25577-1-git-send-email-vz@mleia.com>
Message-ID: <1461714919-25577-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Roland Stigge added initial support of NXP LPC32xx SoC series and
first boards powered by it, but for a while since v3.18-rc1 the
SoC support is unmaintained and became stale.

Vladimir Zapolskiy and Sylvain Lemieux expressed interest in
continuation of NXP LPC32xx maintenance, reflect this in MAINTAINERS
record file for better communication with Linux kernel community.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 233c9bf..e70c5a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1307,8 +1307,10 @@ F:	drivers/rtc/rtc-lpc24xx.c
 N:	lpc18xx
 
 ARM/LPC32XX SOC SUPPORT
-M:	Roland Stigge <stigge@antcom.de>
+M:	Vladimir Zapolskiy <vz@mleia.com>
+M:	Sylvain Lemieux <slemieux.tyco@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+T:	git git://github.com/vzapolskiy/linux-lpc32xx.git
 S:	Maintained
 F:	arch/arm/mach-lpc32xx/
 
-- 
2.8.0.rc3
