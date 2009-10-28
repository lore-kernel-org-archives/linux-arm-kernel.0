From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 28 Oct 2009 23:48:18 +0100
Subject: staging/dream: add TODO file
Message-ID: <20091028224817.GA13987@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds TODO list. It is probably incomplete, as many parts were not
reviewed by the upstream maintainers, yet.

Signed-off-by: Pavel Machek <pavel@ucw.cz>


diff --git a/drivers/staging/dream/TODO b/drivers/staging/dream/TODO
new file mode 100644
index 0000000..38fd221
--- /dev/null
+++ b/drivers/staging/dream/TODO
@@ -0,0 +1,14 @@
+* remove support for wakelocks since those are not in mainline
+
+* camera driver uses old V4L API
+
+* coding style in some places is lacking
+
+* gpio_input.c has some features matrix_keypad lacks. They should be
+merged to gpio_input, with gpio_input.c removed
+
+* pmem provides interface for userspace. Needs to be reviewed at least.
+
+* it is probably possible to simplify touchscreen driver using threaded_irq's.
+
+* touchscreen driver should be switched to oficial multitouch API

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
