From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 19 Apr 2018 16:36:57 +0800
Subject: [PATCH] MAINTAINERS: update entry for entry for ARM/berlin
In-Reply-To: <87fu4jt883.fsf@bootlin.com>
References: <20180329164240.20cfddbc@xhacker.debian>
 <87fu4jt883.fsf@bootlin.com>
Message-ID: <20180419163657.276b1333@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Thu, 29 Mar 2018 13:46:36 +0200 Gregory CLEMENT wrote:

> Hi Jisheng,
>  
>  On jeu., mars 29 2018, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> 
> > Change the entry name and move it to its alphabetical location.
> > We move to ARM/Synaptics instead of ARM/Marvell.
> >
> > This patch also updates my email address from marvell to synaptics.
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  MAINTAINERS | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6e950b8b4a41..0a0da6a8e607 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1578,15 +1578,6 @@ ARM/MAGICIAN MACHINE SUPPORT
> >  M:	Philipp Zabel <philipp.zabel@gmail.com>
> >  S:	Maintained
> >  
> > -ARM/Marvell Berlin SoC support
> > -M:	Jisheng Zhang <jszhang@marvell.com>
> > -M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > -L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > -S:	Maintained
> > -F:	arch/arm/mach-berlin/
> > -F:	arch/arm/boot/dts/berlin*
> > -F:	arch/arm64/boot/dts/marvell/berlin*
> > -
> >  ARM/Marvell Dove/MV78xx0/Orion SOC support
> >  M:	Jason Cooper <jason@lakedaemon.net>
> >  M:	Andrew Lunn <andrew@lunn.ch>
> > @@ -2006,6 +1997,15 @@ F:	arch/arm/boot/dts/stm32*
> >  F:	arch/arm/mach-stm32/
> >  F:	drivers/clocksource/armv7m_systick.c
> >  
> > +ARM/Synaptics Berlin SoC support
> > +M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > +M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	arch/arm/mach-berlin/
> > +F:	arch/arm/boot/dts/berlin*
> > +F:	arch/arm64/boot/dts/marvell/berlin*  
> 
> I though you had move the dts file from
> arch/arm64/boot/dts/marvell/berlin* to arch/arm64/boot/dts/synatpics,
> according a patch you submitted in September.
> 
> What happened?
> 

Sorry, I didn't see your email until a few minutes ago. I have corrected
the email junk-filter rules.

Yes, I sent a patch which did the moving last Sep, but I didn't merge
it and sent out PR, I plan to resend a patch in this development window.

Thanks
