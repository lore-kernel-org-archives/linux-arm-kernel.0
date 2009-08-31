From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 31 Aug 2009 12:43:50 +0200
Subject: [PATCH 4/5] PalmGSM: generalisation of Treo680 code to PalmGSM
In-Reply-To: <200908282213.40873.sleep_walker@suse.cz>
References: <1251333811-22360-1-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-5-git-send-email-sleep_walker@suse.cz>
	<alpine.DEB.2.00.0908271025300.27084@localhost.localdomain>
	<200908282213.40873.sleep_walker@suse.cz>
Message-ID: <20090831104350.GB1353@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2009-08-28 22:13:40, Tom???? 'Sleep_Walker' ??ech wrote:
> Hi,
> 
> Dne ??t 27. srpna 2009 04:31:42 Eric Miao napsal(a):
> > 
> > On Thu, 27 Aug 2009, Tom???? ??ech wrote:
> > 
> > > From: Tom???? ??ech <sleep walker@suse.cz>
> > >
> > > ---
> > > arch/arm/mach-pxa/Kconfig                |    5 +
> > > arch/arm/mach-pxa/Makefile               |    2 +-
> > > arch/arm/mach-pxa/include/mach/palmgsm.h |   60 ++++
> > > arch/arm/mach-pxa/include/mach/treo680.h |   49 ---
> > > arch/arm/mach-pxa/palmgsm.c              |  559 ++++++++++++++++++++++++++++++
> > > arch/arm/mach-pxa/treo680.c              |  528 ----------------------------
> > 
> > I don't actually care too much about the naming - as long as 685 can stay 
> > within treo680.c, I don't see any problem with that. The real question is:
> > is palmgsm.c the proper name for all these devices?
> 
> Well, actually your completely right. PalmGSM is not fitting for all devices to come, more fitting would be something like Palm smartphones because there are CDMA devices to come too. On the other hand, this name is the best I found so far. If you don't mind I would even so...
>

I believe treo680 was better name then. Don't change it if you don't
need to...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
