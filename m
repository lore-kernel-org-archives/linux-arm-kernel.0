From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Sep 2018 15:24:27 +0200
Subject: [PATCH] ARM: u300: regulator: add MODULE_LICENSE()
Message-ID: <20180926132434.3071168-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The missing license showed up as a randconfig warning now, no idea
why we never saw that earlier.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-u300/regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-u300/regulator.c b/arch/arm/mach-u300/regulator.c
index 595b574c2c50..96ec72bd3928 100644
--- a/arch/arm/mach-u300/regulator.c
+++ b/arch/arm/mach-u300/regulator.c
@@ -130,3 +130,5 @@ static int __init u300_init_boardpower(void)
 }
 
 device_initcall(u300_init_boardpower);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Linus Walleij");
-- 
2.18.0
