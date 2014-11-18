From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 18 Nov 2014 19:35:45 +0100
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <20141117150617.GD7046@atomide.com>
References: <20141116075928.GA9763@amd> <20141117101553.GA21151@amd>
 <20141117145545.GC7046@atomide.com> <201411171601.32311@pali>
 <20141117150617.GD7046@atomide.com>
Message-ID: <20141118183545.GA16999@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2014-11-17 07:06:17, Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [141117 07:03]:
> > On Monday 17 November 2014 15:55:46 Tony Lindgren wrote:
> > > 
> > > There's nothing stopping us from initializing the camera code
> > > from pdata-quirks.c for now to keep it working. Certainly the
> > > binding should be added to the driver, but that removes a
> > > dependency to the legacy booting mode if things are otherwise
> > > working.
> > 
> > Tony, legacy board code for n900 is not in mainline tree. And 
> > that omap3 camera subsystem for n900 is broken since 3.5 
> > kernel... (both Front and Back camera on n900 show only green 
> > picture).
> 
> I'm still seeing the legacy board code for n900 in mainline tree :)
> It's deprecated, but still there.
> 
> Are you maybe talking about some other piece of platform_data that's
> no longer in the mainline kernel?
> 
> No idea what might be wrong with the camera though.

Camera support for main and secondary cameras was never mainline, AFAICT.

Merging it will not be easy, as it lacks DT support... and was broken
for long time.

Anyway, flash is kind of important for me, since it makes phone useful
as backup light; and it is simple piece of hw, so I intend to keep it
useful.

       	       	   	    	      	      	  		     Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
