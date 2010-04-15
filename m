From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 15 Apr 2010 20:03:14 +0200
Subject: 2.6.34-rc3 vs zaurus spitz: mistery solved
Message-ID: <20100415180314.GC1443@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

For some reason, spitz will hang very early in boot with SLUB. With
SLOB, it boots fine.

SLUB worked fine in 2.6.33 and SLOB is hidden under CONFIG_EMBEDDED,
so it took a while to figure out.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
