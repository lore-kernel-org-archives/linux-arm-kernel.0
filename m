From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 22 Jun 2016 19:59:59 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: Drop legacy board file for n900
In-Reply-To: <201606221848.41305@pali>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <20160621112944.GV29844@pali> <20160621113215.GP22406@atomide.com>
 <201606221848.41305@pali>
Message-ID: <20160622175959.GA21075@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > OK I'd like to apply this series by Monday if no issues to have
> > enough time for it in Linux next. Does that sound OK to you?
> > 
> > Regards,
> > 
> > Tony
> 
> Ok, now I looked at it and tested current version from torvalds tree.
> 
> There is still missing fixed support for IR, but that is waiting in 
> media tree queue for next merge window.
> 
> So after IR patches land in torvalds tree, I'm fine with dropping legacy 
> board code for n900 and you can add my Acked-by.
> 
> Sorry that it look so long time, but Nokia N900 is omap3 device with 
> most features & drivers.
> 
> I need to say that Nokia N900 support has good support in mainline 
> kernel, probably the best from all mobile phones. It is almost feature 
> complete, missing parts are: DSP, both cameras, bluetooth and RM
> radio.

...and graphics acceleration and power management. But who needs
accelerated graphics, and power management will be solved. So yes,
N900 is the best phone :-).

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
