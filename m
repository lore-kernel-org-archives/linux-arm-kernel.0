From: hjk@hansjkoch.de (Hans J. Koch)
Date: Thu, 22 Dec 2011 22:22:40 +0100
Subject: [PATCH 1/4] Remove Telechips ARM subarch from MAINTAINERS
In-Reply-To: <20111222211948.GA1201@local>
References: <20111222211948.GA1201@local>
Message-ID: <20111222212240.GB1201@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The AMR subarchitecture for Telechips SoCs is completely removed,
so there's no need for a MAINTAINERS entry.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Harry Sievers <hsievers@csselectronic.com>
Signed-off-by: Hans J. Koch <hjk@hansjkoch.de>
---
 MAINTAINERS |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9db108..555afaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1124,13 +1124,6 @@ S:	Supported
 F:	arch/arm/mach-shmobile/
 F:	drivers/sh/
 
-ARM/TELECHIPS ARM ARCHITECTURE
-M:	"Hans J. Koch" <hjk@hansjkoch.de>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/plat-tcc/
-F:	arch/arm/mach-tcc8k/
-
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.7.6.3
