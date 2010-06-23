From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Wed, 23 Jun 2010 22:06:52 +0200
Subject: [PATCH] n35: fix key codes
Message-ID: <4C22695C.2010008@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Someone copied code but forget set key codes.


Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 41f299d..c6bf1cf 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -193,13 +193,13 @@ static struct gpio_keys_button n35_buttons[] = {
 	},
 	{
 		.gpio		= S3C2410_GPG(6),
-		.code		= KEY_DOWN,
+		.code		= KEY_LEFT,
 		.desc		= "Joystick Left",
 		.active_low	= 0,
 	},
 	{
 		.gpio		= S3C2410_GPG(5),
-		.code		= KEY_DOWN,
+		.code		= KEY_RIGHT,
 		.desc		= "Joystick Right",
 		.active_low	= 0,
 	},
-- 
1.7.1
