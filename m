From: pavel@denx.de (Pavel Machek)
Date: Mon, 14 Jul 2014 14:36:22 +0200
Subject: socfpga/sockit ethernet problems
In-Reply-To: <737g3ogvwq.fsf@unicorn.hi.pengutronix.de>
References: <20140507104518.GB18139@amd.pavel.ucw.cz>
 <20140703093548.GA9937@amd.pavel.ucw.cz>
 <1404764751.14294.3.camel@linux-builds1>
 <20140707214340.GA29061@amd.pavel.ucw.cz>
 <737g3ogvwq.fsf@unicorn.hi.pengutronix.de>
Message-ID: <20140714123622.GG14300@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> All of this stuff is not needed as it's already taken care of by the
> >> Micrel phy driver. The clock skew values are now represented in the DTS.
> >> Please look at:
> >> 
> >> Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> >
> > Aah, thanks for the pointer. 
> >
> > At least socfpga_cyclone5_socrates.dts is in the mainline, but it does
> > not have any skew configuration. That may explain why the board seems
> > to have problems with ethernet... (or not).
> 
> The socrates does not have these values, because it does not have a
> Micrel PHY...

Hmm, that is not it, then :-(. Is there any other setup that needs to
be done? Because from the experience with the socrates boards, they
are quite picky about cabling used.

Thanks and best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
