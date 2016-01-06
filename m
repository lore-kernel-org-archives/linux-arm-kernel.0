From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 6 Jan 2016 21:46:27 +0100
Subject: Nokia N900: u-SD card in v4.2+
Message-ID: <20160106204627.GA21477@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

In v4.1, both internal MMC and u-SD cards work ok.

In v4.2, only the internal MMC is detected. In v4.3, not even internal
MMC works. In v4.4, only the internal MMC is detected.

Does it work for you? Any patches?

(I do have hack in the dts to disable back cover detection...)

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
