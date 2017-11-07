From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 7 Nov 2017 20:59:12 +0100
Subject: Battery charging, battery status on Nokia N9, N950
In-Reply-To: <20171107195020.GA19508@amd>
References: <20171103210349.GA14071@amd>
 <20171107195020.GA19508@amd>
Message-ID: <20171107195912.GA3274@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> 
> > I'm fighting with battery status & battery charging on Nokia
> > N9/N950. https://elinux.org/N950 contains enough info to get battery
> > status (and below is first attempt at kernel implementation), but I'm
> > not sure what needs to be done to charge the battery (or at least
> > power phone from USB).
> 
> Nemo recovery system (2824336 Jul 25  2016 zImage-moslo) seems to
> either charge phone from USB or at power it from USB.
> 
> But 4.13 does not; it seems there are two separate issue.
> 
> First, something needs to be done to enable system power from the
> USB. I'm not sure what that one would be :-(. Then, it should be
> possible to ask bq24153 to charge the battery.

If someone has schematics or pointer to them.. for N9 or N950, that
would be useful :-).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171107/a4127a03/attachment.sig>
