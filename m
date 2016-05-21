From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:52:39 +0200
Subject: [PATCH 0125/1529] Fix typo
Message-ID: <20160521115239.5917-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/plat-samsung/include/plat/gpio-cfg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
index b5294ef..21391fa 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
@@ -35,7 +35,7 @@ struct samsung_gpio_chip;
  * struct samsung_gpio_cfg GPIO configuration
  * @cfg_eint: Configuration setting when used for external interrupt source
  * @get_pull: Read the current pull configuration for the GPIO
- * @set_pull: Set the current pull configuraiton for the GPIO
+ * @set_pull: Set the current pull configuration for the GPIO
  * @set_config: Set the current configuration for the GPIO
  * @get_config: Read the current configuration for the GPIO
  *
-- 
2.8.2.534.g1f66975
