From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:42 +0200
Subject: [PATCH 06/40] ARM: mx3_defconfig: add new machine MACH_EUKREA_CPUIMX35
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Furthermore INOTIFY is gone since

	2dfc1ca (inotify: remove inotify in kernel interface)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/configs/mx3_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/mx3_defconfig b/arch/arm/configs/mx3_defconfig
index 161f907..f0c339f 100644
--- a/arch/arm/configs/mx3_defconfig
+++ b/arch/arm/configs/mx3_defconfig
@@ -24,6 +24,7 @@ CONFIG_MACH_PCM043=y
 CONFIG_MACH_ARMADILLO5X0=y
 CONFIG_MACH_MX35_3DS=y
 CONFIG_MACH_KZM_ARM11_01=y
+CONFIG_MACH_EUKREA_CPUIMX35=y
 CONFIG_MXC_IRQ_PRIOR=y
 CONFIG_MXC_PWM=y
 CONFIG_NO_HZ=y
@@ -108,7 +109,6 @@ CONFIG_MMC=y
 CONFIG_MMC_MXC=y
 CONFIG_DMADEVICES=y
 # CONFIG_DNOTIFY is not set
-CONFIG_INOTIFY=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_UBIFS_FS=y
-- 
1.7.2.3
