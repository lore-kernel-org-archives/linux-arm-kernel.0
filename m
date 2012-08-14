From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:28 +0200
Subject: [PATCH 14/23] add at91sam9x5 Kconfig ARCH/SOC link
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-15-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-at91/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index c8050b1..c6eb877 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -141,6 +141,10 @@ config ARCH_AT91SAM9G45
 	bool "AT91SAM9G45"
 	select SOC_AT91SAM9G45
 
+config ARCH_AT91SAM9X5
+	bool "AT91SAM9x5"
+	select SOC_AT91SAM9X5
+
 config ARCH_AT91X40
 	bool "AT91x40"
 	depends on !MMU
-- 
1.7.2.5
