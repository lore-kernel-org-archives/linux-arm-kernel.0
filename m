From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 27 Mar 2018 23:21:56 +0200
Subject: 4.16-rc5 on Motorola Droid 4
In-Reply-To: <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
References: <20180318220418.GA22880@amd> <20180320140322.GU5799@atomide.com>
 <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
Message-ID: <20180327212156.GA10834@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Yeah display related stuff is half merged in Linux next, backlight
> > needs some binding changes from what I remember. I think the
> > minimal set is something like this against v4.16-rc:
> 
> I have an updated lm355x backlight driver almost ready, that uses
> an updated binding scheme and exposes the keyboard backlight
> using the LED subsystem.

If I could get a diff, I'd happily test it :-).

Also, if you know how to get information from light sensor, that would
be nice.

> The keyboard backlight and lcd backlight are controlled by LM3552,
> that's the driver mentioned above. The other LEDs (status rgb,
> shift/capslock, and the android button backlight) are working.

Confirmed. They work, and they have reasonable names.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180327/9400a5d9/attachment-0001.sig>
