From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 18 May 2016 09:49:24 +0200
Subject: 4.5-rc0 regression: GPRS breaks after very short while
Message-ID: <20160518074924.GA20652@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I was afraid another GSM chip desoldered itself in N900, but no, it
seems to be software this time.

In 4.4, GPRS is rock solid, can survive overnight ping.

In 4.5-rc0 and v4.6, modem fails when I use gprs for like a
minute. Phone is not usable.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
