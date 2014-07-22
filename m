From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:12 +0100
Subject: [PATCH 06/19] mfd: dm355evm_msp: Fix checkpatch error: insert space
 after ', '
In-Reply-To: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406027485-15657-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of an effort to clean-up the MFD subsystem.

ERROR: space required after that ',' (ctx:VxV)
+#define MSP_GPIO(bit,reg)      ((DM355EVM_MSP_ ## reg) << 3 | (bit))
                     ^

total: 1 errors, 0 warnings, 437 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/dm355evm_msp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
index 7a55c00..4c826f7 100644
--- a/drivers/mfd/dm355evm_msp.c
+++ b/drivers/mfd/dm355evm_msp.c
@@ -95,7 +95,7 @@ EXPORT_SYMBOL(dm355evm_msp_read);
  * Many of the msp430 pins are just used as fixed-direction GPIOs.
  * We could export a few more of them this way, if we wanted.
  */
-#define MSP_GPIO(bit,reg)	((DM355EVM_MSP_ ## reg) << 3 | (bit))
+#define MSP_GPIO(bit, reg)	((DM355EVM_MSP_ ## reg) << 3 | (bit))
 
 static const u8 msp_gpios[] = {
 	/* eight leds */
-- 
1.8.3.2
