From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  8 Jul 2011 18:20:20 +0800
Subject: [PATCH] ARM: mmp: support OF by default
In-Reply-To: <1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1310120428-22700-4-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support open firmware by default.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 48748fb..7b083a0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -545,6 +545,7 @@ config ARCH_MMP
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
+	select USE_OF
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
-- 
1.5.6.5
