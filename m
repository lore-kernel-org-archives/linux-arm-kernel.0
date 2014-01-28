From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 28 Jan 2014 13:18:26 +0100
Subject: [PATCH 02/18] mfd: max14577: Remove unused enum max14577_irq_source
In-Reply-To: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1390911522-28209-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused symbol: enum max14577_irq_source.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/mfd/max14577-private.h |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/mfd/max14577-private.h b/include/linux/mfd/max14577-private.h
index a3d0185196d3..c9b332fb0d5d 100644
--- a/include/linux/mfd/max14577-private.h
+++ b/include/linux/mfd/max14577-private.h
@@ -248,14 +248,6 @@ enum max14577_charger_reg {
 /* MAX14577 regulator SFOUT LDO voltage, fixed, uV */
 #define MAX14577_REGULATOR_SAFEOUT_VOLTAGE		4900000
 
-enum max14577_irq_source {
-	MAX14577_IRQ_INT1 = 0,
-	MAX14577_IRQ_INT2,
-	MAX14577_IRQ_INT3,
-
-	MAX14577_IRQ_REGS_NUM,
-};
-
 enum max14577_irq {
 	/* INT1 */
 	MAX14577_IRQ_INT1_ADC,
-- 
1.7.9.5
