From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 18 Mar 2014 10:33:57 +0800
Subject: [PATCH 3/3] defconfig: arm: sama5_defconfig: update
In-Reply-To: <1395110037-23151-1-git-send-email-wenyou.yang@atmel.com>
References: <1395110037-23151-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1395110037-23151-4-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to enable CONFIG_AT91_SLOW_CLOCK

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/configs/sama5_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index dc3881e..a15879c 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -201,3 +201,4 @@ CONFIG_CRYPTO_DEV_ATMEL_TDES=y
 CONFIG_CRYPTO_DEV_ATMEL_SHA=y
 CONFIG_CRC_CCITT=m
 CONFIG_CRC_ITU_T=m
+CONFIG_AT91_SLOW_CLOCK=y
-- 
1.7.9.5
