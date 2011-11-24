From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 24 Nov 2011 14:58:04 +0100
Subject: [PATCH 1/3] ARM: at91: rename defconfig files appropriately
In-Reply-To: <201111232115.08556.arnd@arndb.de>
References: <201111232115.08556.arnd@arndb.de>
Message-ID: <1322143086-1788-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rename all Atmel reference board as soc defconfig

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 .../{at91cap9adk_defconfig => at91cap9_defconfig}  |    0
 ...91sam9260ek_defconfig => at91sam9260_defconfig} |    0
 ...91sam9g20ek_defconfig => at91sam9g20_defconfig} |    0
 ...at91sam9rlek_defconfig => at91sam9rl_defconfig} |    0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm/configs/{at91cap9adk_defconfig => at91cap9_defconfig} (100%)
 rename arch/arm/configs/{at91sam9260ek_defconfig => at91sam9260_defconfig} (100%)
 rename arch/arm/configs/{at91sam9g20ek_defconfig => at91sam9g20_defconfig} (100%)
 rename arch/arm/configs/{at91sam9rlek_defconfig => at91sam9rl_defconfig} (100%)

diff --git a/arch/arm/configs/at91cap9adk_defconfig b/arch/arm/configs/at91cap9_defconfig
similarity index 100%
rename from arch/arm/configs/at91cap9adk_defconfig
rename to arch/arm/configs/at91cap9_defconfig
diff --git a/arch/arm/configs/at91sam9260ek_defconfig b/arch/arm/configs/at91sam9260_defconfig
similarity index 100%
rename from arch/arm/configs/at91sam9260ek_defconfig
rename to arch/arm/configs/at91sam9260_defconfig
diff --git a/arch/arm/configs/at91sam9g20ek_defconfig b/arch/arm/configs/at91sam9g20_defconfig
similarity index 100%
rename from arch/arm/configs/at91sam9g20ek_defconfig
rename to arch/arm/configs/at91sam9g20_defconfig
diff --git a/arch/arm/configs/at91sam9rlek_defconfig b/arch/arm/configs/at91sam9rl_defconfig
similarity index 100%
rename from arch/arm/configs/at91sam9rlek_defconfig
rename to arch/arm/configs/at91sam9rl_defconfig
-- 
1.7.7
