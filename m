From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 10 Jul 2018 00:02:11 +0200
Subject: Vibrations on Droid 4?
In-Reply-To: <20180709214910.tes6u4ivxomd3aja@earth.universe>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
Message-ID: <20180709220211.GA7760@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Do you have vibrations on d4 working?
> > I believe I have required drivers enabled, but no luck:
> > 
> > user at devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> > bind  uevent  unbind
> > user at devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> > bind  uevent  unbind
> 
> Have you checked probe deferrals?

Not really. Is there easier way to do that than adding printks in the
probe function? (I can go through dmesg tommorow).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/cd661d69/attachment.sig>
