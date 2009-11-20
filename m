From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 20 Nov 2009 19:24:05 +0100
Subject: [PATCH] hx4700: fix hx4700 touchscreen pressure values
In-Reply-To: <20091118174649.GB4458@core.coreip.homeip.net>
References: <E1NAYJo-00016g-PW@pih-relay04.plus.net>
	<20091118172849.GD25150@elf.ucw.cz>
	<20091118173934.GA4458@core.coreip.homeip.net>
	<20091118174649.GB4458@core.coreip.homeip.net>
Message-ID: <20091120182405.GA1378@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > Dmitry, those pressure values are reverted on more than one machine,
> > > and we do not have anyone reporting it works ok for them. Can we
> > > perhaps just.... fix it?
> > 
> > OK, so we have 4 instances where pressure is inverted and nobody wants
> > to come out with a non-inverted example... I'll queue for .33 then - .32
> > it too close to the release.
> > 
> 
> Btw, could you send me the latest version of your patch please?

Yep, resent in separate mail.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
