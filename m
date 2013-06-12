From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 12 Jun 2013 06:26:13 +0000
Subject: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr info
 clean up
In-Reply-To: <79CD15C6BA57404B839C016229A409A83ECAF796@DBDE04.ent.ti.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
 <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com>
 <87zjv2ooxi.fsf@linaro.org>
 <79CD15C6BA57404B839C016229A409A83ECAF796@DBDE04.ent.ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83ECAF7CB@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Hiremath, Vaibhav
> Sent: Wednesday, June 12, 2013 11:34 AM
> To: Kevin Hilman; Paul Walmsley
> Cc: Shilimkar, Santosh; tony at atomide.com; linux-arm-
> kernel at lists.infradead.org; linux-omap at vger.kernel.org; R, Sricharan
> Subject: RE: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr
> info clean up
> 
> 
> > -----Original Message-----
> > From: Kevin Hilman [mailto:khilman at linaro.org]
> > Sent: Friday, June 07, 2013 3:57 AM
> > To: Paul Walmsley
> > Cc: Shilimkar, Santosh; tony at atomide.com; linux-arm-
> > kernel at lists.infradead.org; linux-omap at vger.kernel.org; Hiremath,
> > Vaibhav; R, Sricharan
> > Subject: Re: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr
> > info clean up
> >
> > Paul Walmsley <paul@pwsan.com> writes:
> >
> > > On Wed, 29 May 2013, Santosh Shilimkar wrote:
> > >
> > >> From: Vaibhav Hiremath <hvaibhav@ti.com>
> > >>
> > >> AM33XX only supports DT boot mode and with addition of
> > >> extracting module resources like, irq, dma and address space
> > >> from DT block, so now we can remove duplicate information from
> > >> hwmod data file.
> > >
> > > OK, guess I'll take your word for it that it all works.  The
> > > BeagleBone-white with appended DTB hasn't booted here since v3.7.
> > > And the BeagleBone-black with discrete DTB doesn't boot at all with
> > > current mainline, only with the TI vendor kernel & DTB...
> >
> > Anyone care to shed light on what's missing for BeagleBone boot with
> > mainline currently?
> >
> > I've also not been able to boot a mainline kernel on the BeagleBone
> for
> > some time.
> >
> 
> Sorry for delayed response, as I was on vacation for almost for a week.
> 
> I have just responded to this thread on complete analysis of the issue.
> 
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg90309.html
> 

I have also pushed the branch to github,

https://github.com/hvaibhav/am335x-linux.git  linus-master

OR

https://github.com/hvaibhav/am335x-linux/tree/linus-master


NOTE: Tested on BeagleBone-Black platform.

Thanks,
Vaibhav
