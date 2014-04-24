From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 24 Apr 2014 17:21:56 +0200
Subject: socfpga in 3.15-rc2
In-Reply-To: <734n1i25ad.fsf@unicorn.hi.pengutronix.de>
References: <20140424125421.GA19526@amd.pavel.ucw.cz>
 <734n1i25ad.fsf@unicorn.hi.pengutronix.de>
Message-ID: <20140424152156.GA22540@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Does socfpga boot for you on 3.15-rc2? Mainline worked on 3.14 pretty
> > well, but I get no output from serial from 3.15-rc2. Any ideas?
> >
> 
> You need:
> 
> [PATCH] clk: socfpga: fix clock driver for 3.15
> Message-Id: 1397481336-5592-1-git-send-email-dinguyen at altera.com

Thanks a lot, with that patch, I'm back to working system.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
