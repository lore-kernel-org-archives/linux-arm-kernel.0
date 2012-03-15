From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Mar 2012 14:00:14 +0100
Subject: [PATCH 6/6] ARM: at91/Kconfig: website link for AT91SAM9G20-EK
In-Reply-To: <feb3f4c639fae3f01636ba2017968fac1078ddca.1331816340.git.nicolas.ferre@atmel.com>
References: <feb3f4c639fae3f01636ba2017968fac1078ddca.1331816340.git.nicolas.ferre@atmel.com>
Message-ID: <02d9058446476af7961360b126768339ba4f6b7f.1331816340.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 24da4cc..79e69bf 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -379,6 +379,7 @@ config MACH_AT91SAM9G20EK_2MMC
 	  Select this if you are using an Atmel AT91SAM9G20-EK Evaluation Kit
 	  with 2 SD/MMC Slots. This is the case for AT91SAM9G20-EK rev. C and
 	  onwards.
+	  <http://www.atmel.com/tools/SAM9G20-EK.aspx>
 
 config MACH_CPU9G20
 	bool "Eukrea CPU9G20 board"
-- 
1.7.9
