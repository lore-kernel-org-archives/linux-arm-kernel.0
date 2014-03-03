From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Mon,  3 Mar 2014 11:05:58 +0100
Subject: [PATCH v5 5/9] at91: dt: defconfig: Added the sam9261 to the list of
 DT-enabled SOCs
In-Reply-To: <1393841162-25339-1-git-send-email-jjhiblot@traphandler.com>
References: <1393841162-25339-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1393841162-25339-6-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 0b4e9b5..3c6905d 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -16,6 +16,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_AT91=y
 CONFIG_SOC_AT91RM9200=y
 CONFIG_SOC_AT91SAM9260=y
+CONFIG_SOC_AT91SAM9261=y
 CONFIG_SOC_AT91SAM9263=y
 CONFIG_SOC_AT91SAM9G45=y
 CONFIG_SOC_AT91SAM9X5=y
-- 
1.9.0
