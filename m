From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 28 Apr 2016 10:45:46 +0200
Subject: drivers/media/i2c/adp1653.c: does not show as /dev/video* or
 v4l-subdev*
Message-ID: <20160428084546.GA9957@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On n900, probe finishes ok (verified by adding printks), and the
device shows up in /sys, but I  don't get /dev/video* or
/dev/v4l-subdev*.

Other drivers (back and front camera) load ok, and actually work. Any
idea what could be wrong?

Thanks,
								Pavel
--
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
