From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 29 Nov 2009 09:34:25 +0100
Subject: [PATCH] ARM: gta02: Add gpio bank B quirk for hardware
	revision 5 and earlier
In-Reply-To: <1259377532-8012-5-git-send-email-lars@metafoo.de>
References: <1259377532-8012-1-git-send-email-lars@metafoo.de>
	<1259377532-8012-2-git-send-email-lars@metafoo.de>
	<1259377532-8012-3-git-send-email-lars@metafoo.de>
	<1259377532-8012-4-git-send-email-lars@metafoo.de>
	<1259377532-8012-5-git-send-email-lars@metafoo.de>
Message-ID: <20091129083425.GB1530@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On gta02 hardware revision 5 and earlier the basis resistors for transistors of
> the leds are missing and reading their gpio pin status will always return 0.
> So we have to shadow the led states in software. This is done by "hijacking"
> the gpio accessor functions for bank B.

Should that be done in LED driver, instead?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
