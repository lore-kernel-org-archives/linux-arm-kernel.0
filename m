From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 20 Nov 2017 23:15:51 +0100
Subject: Nokia N900: Funny screen effects, v4.14 with certain configs
Message-ID: <20171120221550.GA13322@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I'm trying to find common configuration for N900, N9 and N950.

...and I found that N900, at least with DRM configuration, is
flakey. Depending on exact .config, and exact way I boot it (timing of
0xffff) display either works or just shows moving horizontal stripes.

In particular, ondemand cpufreq seems to be required for display to
work. Ouch. Yes.

If someone knows what is going on there, or has some better
understanding, let me know.

I do have other configuration that seems to work 100% of
time... unfortuantely that one is useless on N9/N950.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171120/3b456a36/attachment.sig>
