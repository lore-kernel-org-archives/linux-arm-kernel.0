From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 30 Sep 2009 14:06:55 +0200
Subject: 2.6.32-rc1: spitz boots but suspend/resume is broken
Message-ID: <20090930120655.GG1412@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

matrix keyboard driver needs to be enabled, otherwise it seems ok.

Unfortunately, it does not respond to power button in any visible way
:-(. Any ideas what might be wrong/how to debug it?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
