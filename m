From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 20 Nov 2009 12:39:15 +0100
Subject: Allow selecting MSM framebuffer in Kconfig
Message-ID: <20091120113915.GA5154@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Allow user to select MSM framebuffer support in Kconfig.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 188e1ba..b3e05e4 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2127,7 +2127,7 @@ config FB_PRE_INIT_FB
 	  the bootloader.
 
 config FB_MSM
-	tristate
+	tristate "MSM Framebuffer support"
 	depends on FB && ARCH_MSM
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
