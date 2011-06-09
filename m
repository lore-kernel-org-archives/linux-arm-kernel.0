From: wdgvip@gmail.com (Wu DaoGuang)
Date: Thu,  9 Jun 2011 09:03:20 +0800
Subject: [PATCH 2/4] This patch fixes Makefile for mach-ok2440.c
In-Reply-To: <1307581402-3808-1-git-send-email-wdgvip@gmail.com>
References: <1307581402-3808-1-git-send-email-wdgvip@gmail.com>
Message-ID: <1307581402-3808-2-git-send-email-wdgvip@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for ok2440 development board.

The following patches are against v3.0-rc2.

Signed-off-by: Wu DaoGuang <wdgvip@gmail.com>
---
 arch/arm/mach-s3c2440/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Makefile b/arch/arm/mach-s3c2440/Makefile
index d5440fa..da4ad71 100644
--- a/arch/arm/mach-s3c2440/Makefile
+++ b/arch/arm/mach-s3c2440/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_MACH_ANUBIS)	+= mach-anubis.o
 obj-$(CONFIG_MACH_OSIRIS)	+= mach-osiris.o
 obj-$(CONFIG_MACH_RX3715)	+= mach-rx3715.o
 obj-$(CONFIG_ARCH_S3C2440)	+= mach-smdk2440.o
+obj-$(CONFIG_MACH_OK2440)	+= mach-ok2440.o
 obj-$(CONFIG_MACH_NEXCODER_2440) += mach-nexcoder.o
 obj-$(CONFIG_MACH_AT2440EVB) += mach-at2440evb.o
 obj-$(CONFIG_MACH_MINI2440) += mach-mini2440.o
-- 
1.7.1
