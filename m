From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 1 Sep 2009 02:07:16 +0200
Subject: [PATCH 4/5] PalmGSM: generalisation of Treo680 code to PalmGSM
In-Reply-To: <200908311306.43005.sleep_walker@suse.cz>
References: <1251333811-22360-1-git-send-email-sleep_walker@suse.cz>
	<200908282213.40873.sleep_walker@suse.cz>
	<20090831104350.GB1353@ucw.cz>
	<200908311306.43005.sleep_walker@suse.cz>
Message-ID: <20090901000716.GD2985@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ahoj! / Hi!

> > > > > arch/arm/mach-pxa/Kconfig                |    5 +
> > > > > arch/arm/mach-pxa/Makefile               |    2 +-
> > > > > arch/arm/mach-pxa/include/mach/palmgsm.h |   60 ++++
> > > > > arch/arm/mach-pxa/include/mach/treo680.h |   49 ---
> > > > > arch/arm/mach-pxa/palmgsm.c              |  559 ++++++++++++++++++++++++++++++
> > > > > arch/arm/mach-pxa/treo680.c              |  528 ----------------------------
> > > > 
> > > > I don't actually care too much about the naming - as long as 685 can stay 
> > > > within treo680.c, I don't see any problem with that. The real question is:
> > > > is palmgsm.c the proper name for all these devices?
> > > 
> > > Well, actually your completely right. PalmGSM is not fitting for all devices to come, more fitting would be something like Palm smartphones because there are CDMA devices to come too. On the other hand, this name is the best I found so far. If you don't mind I would even so...
> > >
> > 
> > I believe treo680 was better name then. Don't change it if you don't
> > need to...
> 
> But I need to have different generic name - treo680 will be occupied by Treo680 specific stuff, which makes more sense, doesn't it?
> 

And rename generic code to treo.c? Then you could have treo.c for
generic code, and treo680.c / treo685.c for specific models...

palmgsm.c sounds like driver for their GSM chip...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
