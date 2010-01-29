From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 09:02:19 +0000
Subject: [PATCH] ARM: SAMSUNG: Select NO_IOPORT for plat-samsung
In-Reply-To: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
References: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264755741-16184-9-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All these platforms select NO_IOPORT, so move it to plat-samsung Kconfig

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 93bd893..d552c65 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -7,6 +7,7 @@
 config PLAT_SAMSUNG
 	bool
 	depends on ARCH_S3C2410 || ARCH_S3C24A0 || ARCH_S3C64XX || ARCH_S5PC1XX
+	select NO_IOPORT
 	default y
 	help
 	  Base platform code for all Samsung SoC based systems
-- 
1.6.0.4
