From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:00:12 +0900
Subject: [PATCH 11/17] ARM: SMDKV310: Enable I2C1 device
In-Reply-To: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1292562012-19940-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Enable the I2C_1 device on SMDKV310 and SMDKC210

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pv310/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index d64efe0..67d7032 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -75,6 +75,8 @@ config MACH_SMDKC210
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
 	select S5PV310_SETUP_SDHCI
+	select S3C_DEV_I2C1
+	select S5PV310_SETUP_I2C1
 	help
 	  Machine support for Samsung SMDKC210
 	  S5PC210(MCP) is one of package option of S5PV310
@@ -103,6 +105,8 @@ config MACH_SMDKV310
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
 	select S5PV310_SETUP_SDHCI
+	select S3C_DEV_I2C1
+	select S5PV310_SETUP_I2C1
 	help
 	  Machine support for Samsung SMDKV310
 
-- 
1.6.2.5
