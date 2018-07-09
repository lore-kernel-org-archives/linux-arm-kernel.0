From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 9 Jul 2018 10:15:35 +0200
Subject: Vibrations on Droid 4?
Message-ID: <20180709081534.GA6799@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Do you have vibrations on d4 working?

I believe I have required drivers enabled, but no luck:

user at devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
bind  uevent  unbind
user at devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
bind  uevent  unbind

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180709/b97455c4/attachment.sig>
