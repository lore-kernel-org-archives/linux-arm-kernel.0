From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 11 May 2010 02:03:26 +0100
Subject: next-samsung: acer n30/n35 updates
In-Reply-To: <4BE37CCA.30406@vscht.cz>
References: <20100507005050.GY2589@trinity.fluff.org> <4BE37CCA.30406@vscht.cz>
Message-ID: <20100511010326.GC26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 07, 2010 at 04:36:58AM +0200, Pinkava J. wrote:
> Dne 7.5.2010 02:50, Ben Dooks napsal(a):
> > Acer n35 support has been provisonally merged into the following branch:
> > 
> >   git://git.fluff.org/bjdooks/linux.git for-2635/acer-n35
> > 
> > If there are any objections, then let me know, otherwise this will be
> > merged into next-samsug this weekend ready to go in the next merge window.
> > 
> > Jiri, please confirm that you've read Section 12 'Sign your work' of
> > Documentation/SubmittingPatches and that you agree to the part on
> > "Developer's Certificate of Origin 1.1"
> I comfirming that I've read above mentioned.
> 
> In order to be absolutely clear I must mention that patches 4-7 are based on old
> patches from Christer Weinigel (author of current implementation of Samsung n30
> code in kernel). Is this OK?

I'd run this past Christer if he wasn't already copied in on them.
 
> >From may point of view I can agree with the part "Developer's Certificate of
> Origin 1.1"
> > 
> > The following commits are in:
> > 
> > Pinkava J (7):
> >       ARM: n30: Enable Acer n35 if Acer n30 is selected
> >       ARM: n30: fix: suspended wrong USB port on Acer n35
> >       ARM: n30: Add RTC platform device for Acer n30 / Acer n35
> >       ARM: n35: Add support for LEDs on Acer n35
> >       ARM: n35: Enable wake-up by Power button on Acer n35
> >       ARM: n30: Add support for MMC card reader on Acer n30 / Acer n35
> >       ARM: n30: Add support for power on/off on Acer n30 / Acer n35 MMC card reader
> > 
> >  arch/arm/mach-s3c2410/Kconfig    |    7 ++++
> >  arch/arm/mach-s3c2410/mach-n30.c |   65 +++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 71 insertions(+), 1 deletions(-)
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
