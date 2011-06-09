From: wdgvip@gmail.com (Wu DaoGuang)
Date: Thu,  9 Jun 2011 09:03:21 +0800
Subject: [PATCH 3/4] This patch fixed the Kconfig for mach-ok2440.c
In-Reply-To: <1307581402-3808-1-git-send-email-wdgvip@gmail.com>
References: <1307581402-3808-1-git-send-email-wdgvip@gmail.com>
Message-ID: <1307581402-3808-3-git-send-email-wdgvip@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Kconfig to support ok2440 development board.

The following patches are against v3.0-rc2.

Signed-off-by: Wu DaoGuang <wdgvip@gmail.com>
---
 arch/arm/mach-s3c2440/Kconfig |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index 50825a3..9b1024d 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -176,6 +176,15 @@ config MACH_AT2440EVB
 	help
 	  Say Y here if you are using the AT2440EVB development board
 
+config MACH_OK2440
+	bool "OK2440 development board"
+	select CPU_S3C2440
+	select S3C2440_XTAL_12000000
+	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
+	help
+	   Say y here to select support for OK2440. 
+
 config MACH_MINI2440
 	bool "MINI2440 development board"
 	select CPU_S3C2440
-- 
1.7.1
