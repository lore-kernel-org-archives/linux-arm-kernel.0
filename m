From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 7 Jan 2011 14:10:50 +0530
Subject: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for build
	break because of clktrctrl_mask
In-Reply-To: <87ipy1vqdi.fsf@ti.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com><87fwt7z1p3.fsf@ti.com><alpine.DEB.2.00.1101061059590.22048@utopia.booyaka.com>
	<87ipy1vqdi.fsf@ti.com>
Message-ID: <3f76fc53e9b50d75480bcfe1d2b6312e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org
[mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Thursday, January 06, 2011 11:58 PM
> To: Paul Walmsley
> Cc: Santosh Shilimkar; linux-omap at vger.kernel.org; tony at atomide.com;
linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for
build break because of clktrctrl_mask
>
> Paul Walmsley <paul@pwsan.com> writes:
>
> > On Wed, 5 Jan 2011, Kevin Hilman wrote:
> >
> >> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> >>
> >> > struct clockdomain member clktrctrl_mask is available for only for
OMAP2
> >> > and OMAP3 architectures. Technially it is also used only for these
archs
> >> > but this breaks the build with custom OMAP4 configuration.
> >>
> >> I'll queue patches 3-5 for the 2.6.38-rc fixes cycle.
> >>
> >> With Paul's ack, I can queue the others too, or Paul can decide to
take
> >> them via his tree.  Paul can decide.
> >
> > I've acked one and requested minor changes on the other, after which
it
> > can be acked by me.  You're welcome to take them at that point.  Just
a
> > request, maybe you can post a branch with just these patches in them;
that
> > way Rajendra and/or I can rebase his new clockdomain changes on it
until
> > -rc1 comes out.
>
> Sure, will do.

Just another trivial fix.
