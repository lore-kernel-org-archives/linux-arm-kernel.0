From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 18 Oct 2017 14:28:04 +0200
Subject: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery:
 Add capacity handling
In-Reply-To: <20170908113231.GJ18365@amd>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
 <20170829101147.debhadzyfrxhkrvt@earth>
 <20170908113231.GJ18365@amd>
Message-ID: <20171018122804.GA14376@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Without patch description: See Last Question in
> > 
> > Documentation/power/power_supply_class.txt
> 
> ...should be done in libbattery, yet to be written. :-).
> 
> Do you have specific guidance what you'd like to see in libbattery?

So I started something, it is at.

https://github.com/pavelmachek/libbattery

My battery on n900 is currently uncalibrated (and charging), still it
gets some kind of estimation:

Battery -1 %
Seconds -1
State 1
Voltage 3.88 V
Battery 63 %

Of course, there's a lot more work to be done.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171018/fb6dfa3d/attachment.sig>
