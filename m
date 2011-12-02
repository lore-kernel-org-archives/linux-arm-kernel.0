From: vishwanath.bs@ti.com (Vishwanath Sripathy)
Date: Fri, 2 Dec 2011 22:28:54 +0530
Subject: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain support via
 hwmod mux
In-Reply-To: <3968ef2671e202d1cefdf4a7c5d32ec6@mail.gmail.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com><87pqh3qvkt.fsf@ti.com><1e686270c099fa4a270b6b01e6ac585c@mail.gmail.com><a480ee86d60a9db484d3baa0faf2477f@mail.gmail.com>
 <87k46izb8b.fsf@ti.com> <3968ef2671e202d1cefdf4a7c5d32ec6@mail.gmail.com>
Message-ID: <f1252b7ed1e3731c8b0c18e385dcdc2b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

> -----Original Message-----
> From: Vishwanath Sripathy [mailto:vishwanath.bs at ti.com]
> Sent: Wednesday, November 30, 2011 2:58 PM
> To: Kevin Hilman
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain
> support via hwmod mux
>
> ---
> > >> > Can you refresh this against Tony's 'fixes' branch and re-
> test.
> > >> >
> > >> > I tested this on OMAP3430/n900 and noticed that it no longer
> > hit
> > >> off
> > >> > mode from idle.
> > >> >
> > >> > IOW, If I enable UART timeouts and then enable off mode, I
> > don't
> > >> > actually ever hit off during idle.  However, if I do a
> > >> > suspend/resume I
> > >> > see it hits off mode, then subsequent attempts to hit off
> > during
> > >> > idle work.
> > >> >
> > >> > Can you investigate this?
> > >> OK. Let me check that.
> > > I rebased these patches against latest Tony's fixes branch and
> > tested it
> > > on OMAP3430 SDP. I see that Core enters off mode in idle path
> > after
> > > setting UART timeout w/o having to suspend the system.
> >
> > OK, sounds good.
> >
> > Do you have a branch that I can test as well?
> Sure. It's available at
> git://gitorious.org/omap-pm/linux.git for_3.3/io_daisy_chain
Did you get any chance to test it at your side?
Should I post the rebased patches?

Regards
Vishwa
>
> Regards
> Vishwa
> >
> > Kevin
