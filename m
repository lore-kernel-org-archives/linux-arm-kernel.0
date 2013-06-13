From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 13 Jun 2013 15:26:24 +0200
Subject: N900 device tree conversion: how to do first step
In-Reply-To: <20130609201119.GA3190@blackmetal.musicnaut.iki.fi>
References: <20130609015944.GA23559@amd.pavel.ucw.cz>
 <20130609201119.GA3190@blackmetal.musicnaut.iki.fi>
Message-ID: <20130613132624.GA3464@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I'd like to convert Nokia N900 to device tree.
> > 
> > Unfortunately, serial port is not easily available (very special cable
> > would be needed, does someone know where to get one?) and I don't have
> > BDI (and very special cable would be needed, too).
> > 
> > So I tried doing very small first step, hoping that I get booting
> > system... obviously I did not.
> 
> The following works for me, it's enough to boot and get the USB networking
> working. After that I can connect to the device with ssh. I don't use
> serial either, I just have initramfs with busybox+dropbear with hardcoded
> interface setup.

Nice.... thanks a lot.

Did you get video to work with the device tree? That's what I'd like
to accomplish now.

If I init spi manually (and some more hacks), it works in the
qemu. But I have not tested on real hw for a while.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
