From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Jan 2018 17:28:02 +0100
Subject: [PATCH] ARM: pxa/tosa-bt: add MODULE_LICENSE tag
Message-ID: <20180110162816.431038-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this tag, we get a build warning:

WARNING: modpost: missing MODULE_LICENSE() in arch/arm/mach-pxa/tosa-bt.o

For completeness, I'm also adding author and description fields.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/tosa-bt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-pxa/tosa-bt.c b/arch/arm/mach-pxa/tosa-bt.c
index 107f37210fb9..83606087edc7 100644
--- a/arch/arm/mach-pxa/tosa-bt.c
+++ b/arch/arm/mach-pxa/tosa-bt.c
@@ -132,3 +132,7 @@ static struct platform_driver tosa_bt_driver = {
 	},
 };
 module_platform_driver(tosa_bt_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dmitry Baryshkov");
+MODULE_DESCRIPTION("Bluetooth built-in chip control");
-- 
2.9.0
