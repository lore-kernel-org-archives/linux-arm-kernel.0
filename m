From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 1 Jul 2013 22:53:53 +0200
Subject: [PATCH] N900: fix operation on emulator
In-Reply-To: <51D1C8DD.6040409@cogentembedded.com>
References: <20130613142809.GA3775@amd.pavel.ucw.cz>
 <20130613145724.GH8164@atomide.com>
 <20130613155240.GB3775@amd.pavel.ucw.cz>
 <20130613161418.GJ8164@atomide.com>
 <20130613230808.GA14876@amd.pavel.ucw.cz>
 <20130614055629.GM8164@atomide.com>
 <20130614212816.GA31768@atrey.karlin.mff.cuni.cz>
 <20130617111031.GQ20992@atomide.com>
 <20130701140315.GA15318@amd.pavel.ucw.cz>
 <51D1C8DD.6040409@cogentembedded.com>
Message-ID: <20130701205353.GB22174@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >Errata workarounds for N900 hardware actually break operation on
> >emulator. Fix it.
> 
> >This approach was suggested by Pali Roh?r <pali.rohar@gmail.com>
> >(thanks!).
> 
> >(Also explain what "sleep_ind" led actually does).
> 
>    Looks like unrelated change and probably worth another patch?

Ok, more serious issue is that code this was modifying is not yet in
mainline. Sorry.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
