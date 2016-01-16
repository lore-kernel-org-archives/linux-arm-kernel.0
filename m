From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 17 Jan 2016 00:22:22 +0100
Subject: Nokia N900: annoying yellow LED while battery is charging (and some
 progress with free userspace)
Message-ID: <20160116232222.GB10962@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

While battery is charging, 3 color LED produces yellow light.. at
quite high intensity, which makes screen unpleasant to look at (with
4.4 kernel).

I'm pretty sure original Maemo did not try to blind me.

It looks like CHRG_IND signal goes from charger to LEDs, and BOOT_MODE
pin may be involved.

Any idea how to get rid of the light?

(And yes, I have some progress; tui project on gitlab now contains
enough to do voice calls with Debian+Ofono+pulseaudio+cmtspeech
utility. Audio latency is bit high, but it is already somehow usable.)

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
