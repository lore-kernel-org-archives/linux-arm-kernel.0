From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 5 Dec 2013 15:00:38 -0800
Subject: [PATCH 2/2] ARM: bcm_defconfig: Unset CONFIG_CRYPTO_ANSI_CPRNG
In-Reply-To: <1386284438-11099-1-git-send-email-tim.kryger@linaro.org>
References: <1386284438-11099-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1386284438-11099-3-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not build the Pseudo Random Number Generation for Cryptographic
modules since it is not currently being used for this platform.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/configs/bcm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index 574e046..ef03bba 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -119,6 +119,7 @@ CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=110
 CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
 # CONFIG_FTRACE is not set
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_CCITT=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRC_ITU_T=y
-- 
1.8.0.1
