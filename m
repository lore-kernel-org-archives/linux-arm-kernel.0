From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 12 Feb 2015 16:06:08 +0100
Subject: 3.20-rc0: very poor performance when running festival
Message-ID: <20150212150608.GA14349@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I'm using

echo 'Come shall then well bload? Then well bload shell when blaight!' | bash -c 'time festival --tts'

to test audio, and I noticed that in 3.20-rc0, it takes about 3x longer
than it should, on Nokia N900. Normally on 3.19, it takes 12 seconds,
but it takes 30 on 3.20.

Any ideas?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
