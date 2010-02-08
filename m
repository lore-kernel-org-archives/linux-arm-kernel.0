From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  8 Feb 2010 10:09:40 +0100
Subject: [PATCH 3/3] gpiolib: document that names can contain printk format
	specifiers
In-Reply-To: <20100203155558.GH11354@pengutronix.de>
References: <20100203155558.GH11354@pengutronix.de>
Message-ID: <1265620180-14150-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 include/asm-generic/gpio.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 37af893..abdb5d3 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -60,7 +60,8 @@ struct module;
  * @names: if set, must be an array of strings to use as alternative
  *      names for the GPIOs in this chip. Any entry in the array
  *      may be NULL if there is no alias for the GPIO, however the
- *      array must be @ngpio entries long.
+ *      array must be @ngpio entries long.  A name can include a single printk
+ *      format specifier for an unsigned int.
  *
  * A gpio_chip can help platforms abstract various sources of GPIOs so
  * they can all be accessed through a common programing interface.
-- 
1.6.6
