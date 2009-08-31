From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1_=27Sleep=5FWalker=27?=
	=?utf-8?q?_=C4=8Cech?=)
Date: Mon, 31 Aug 2009 13:06:42 +0200
Subject: [PATCH 4/5] PalmGSM: generalisation of Treo680 code to PalmGSM
In-Reply-To: <20090831104350.GB1353@ucw.cz>
References: <1251333811-22360-1-git-send-email-sleep_walker@suse.cz>
	<200908282213.40873.sleep_walker@suse.cz>
	<20090831104350.GB1353@ucw.cz>
Message-ID: <200908311306.43005.sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Dne Po 31. srpna 2009 12:43:50 Pavel Machek napsal(a):
> On Fri 2009-08-28 22:13:40, Tom???? 'Sleep_Walker' ??ech wrote:
> > Hi,
> > 
> > Dne ??t 27. srpna 2009 04:31:42 Eric Miao napsal(a):
> > > 
> > > On Thu, 27 Aug 2009, Tom???? ??ech wrote:
> > > 
> > > > From: Tom???? ??ech <sleep walker@suse.cz>
> > > >
> > > > ---
> > > > arch/arm/mach-pxa/Kconfig                |    5 +
> > > > arch/arm/mach-pxa/Makefile               |    2 +-
> > > > arch/arm/mach-pxa/include/mach/palmgsm.h |   60 ++++
> > > > arch/arm/mach-pxa/include/mach/treo680.h |   49 ---
> > > > arch/arm/mach-pxa/palmgsm.c              |  559 ++++++++++++++++++++++++++++++
> > > > arch/arm/mach-pxa/treo680.c              |  528 ----------------------------
> > > 
> > > I don't actually care too much about the naming - as long as 685 can stay 
> > > within treo680.c, I don't see any problem with that. The real question is:
> > > is palmgsm.c the proper name for all these devices?
> > 
> > Well, actually your completely right. PalmGSM is not fitting for all devices to come, more fitting would be something like Palm smartphones because there are CDMA devices to come too. On the other hand, this name is the best I found so far. If you don't mind I would even so...
> >
> 
> I believe treo680 was better name then. Don't change it if you don't
> need to...

But I need to have different generic name - treo680 will be occupied by Treo680 specific stuff, which makes more sense, doesn't it?

Best regards,

Tomas Cech
