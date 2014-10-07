From: pavel@denx.de (Pavel Machek)
Date: Tue, 7 Oct 2014 14:10:18 +0200
Subject: socfpga ethernet problems with ethernet in 3.17 with u-boot-2013.01.01
Message-ID: <20141007121017.GA20998@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

After some testing:

u-boot-2013.01.01 + linux-3.17 => ethernet does	not work
                  (unless ethernet is used in u-boot, for example
                  using ping)
u-boot-marex-20140920a + linux-3.17 => working ethernet

One of our guesses is that maybe we don't pull ethernet out of reset
in the first case?

Best regards,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
