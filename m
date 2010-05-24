From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 24 May 2010 04:30:07 +0100
Subject: [PATCH 6/8] ARM: SAMSUNG: Fix documentation for s3c_gpio_cfgpin()
In-Reply-To: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
References: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274671809-9821-7-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix typo in s3c_gpio_cfgpin() documentation, the second argument is @to
not @pin again.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/include/plat/gpio-cfg.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
index 34efdd2..4683823 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
@@ -70,7 +70,7 @@ struct s3c_gpio_cfg {
 /**
  * s3c_gpio_cfgpin() - Change the GPIO function of a pin.
  * @pin pin The pin number to configure.
- * @pin to The configuration for the pin's function.
+ * @to to The configuration for the pin's function.
  *
  * Configure which function is actually connected to the external
  * pin, such as an gpio input, output or some form of special function
-- 
1.6.3.3
