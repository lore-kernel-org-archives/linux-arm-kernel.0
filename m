From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 27 Jan 2010 18:13:08 +0100
Subject: spitz (arm pda): time no longer ok after resume
Message-ID: <20100127171308.GA24875@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

It seems that spitz has problems with time after resume; time while it
was sleeping is not accounted. This seems to be regression in
2.6.33-rc5.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
