From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 6 Nov 2013 15:32:48 +0100
Subject: [RFC 4/4] ASoC: RX-51: Add DT support to sound driver
In-Reply-To: <1382909086-10493-5-git-send-email-sre@debian.org>
References: <1382909086-10493-1-git-send-email-sre@debian.org>
 <1382909086-10493-5-git-send-email-sre@debian.org>
Message-ID: <20131106143248.GD15551@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> This patch adds device tree support to the Nokia N900 audio driver.

Note, N900 audio driver.

> +- compatible: "nokia,rx51-audio"

Still, it is rx51-audio. If it is feasible, could we move away from
rx51 naming and into n900 naming that is familiar to mere humans?

We can rename the sources later, but I guess we should get dts binding
right first time...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
