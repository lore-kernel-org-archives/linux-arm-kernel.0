From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Sun, 28 Nov 2010 20:30:24 +0200
Subject: [PATCH 06/10] ARM S3C24XX: Compile NAND device definition for SMDK
	boards
In-Reply-To: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
Message-ID: <1290969027-10178-6-git-send-email-jekhor@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>

Common SMDK code uses s3c_device_nand, but doesn't select it in Kconfig.

Signed-off-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
---
 arch/arm/plat-s3c24xx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 5a27b1b..f3e22f9 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -155,6 +155,7 @@ config S3C2412_IOTIMING
 
 config MACH_SMDK
 	bool
+	select S3C_DEV_NAND
 	help
 	  Common machine code for SMDK2410 and SMDK2440
 
-- 
1.7.2.3
