From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 21 Apr 2014 13:05:27 +0800
Subject: [PATCH] defconfig: sama5_defconfig: updated
Message-ID: <1398056727-21339-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

due to enabling
	-- CONFIG_REGULATOR
	-- CONFIG_REGULATOR_ACT8865

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
Hi Nicolas,

The patch is based on the branch: at91-3.10-dt
	git://github.com/at91linux/linux-at91.git

Best Regards,
Wenyou Yang

 arch/arm/configs/sama5_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index dc3881e..2b9891e 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -201,3 +201,5 @@ CONFIG_CRYPTO_DEV_ATMEL_TDES=y
 CONFIG_CRYPTO_DEV_ATMEL_SHA=y
 CONFIG_CRC_CCITT=m
 CONFIG_CRC_ITU_T=m
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_ACT8865=y
-- 
1.7.9.5
