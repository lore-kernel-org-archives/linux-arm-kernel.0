From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Tue, 18 Sep 2012 18:59:59 +0200
Subject: [PATCH v2] arch/arm/mach-davinci/board-dm646x-evm.c: Remove
 unecessary semicolon
Message-ID: <1347987599-30802-1-git-send-email-peter.senna@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Found by http://coccinelle.lip6.fr/

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 958679a..1ccaace 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -193,7 +193,7 @@ static int evm_led_setup(struct i2c_client *client, int gpio,
 	while (ngpio--) {
 		leds->gpio = gpio++;
 		leds++;
-	};
+	}
 
 	evm_led_dev = platform_device_alloc("leds-gpio", 0);
 	platform_device_add_data(evm_led_dev, &evm_led_data,
-- 
1.7.11.4
