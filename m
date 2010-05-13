From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 13 May 2010 13:11:43 +0200
Subject: S5PC100 planning
In-Reply-To: <006901caf283$60709930$2151cb90$%kim@samsung.com>
References: <20100513042545.GT6684@trinity.fluff.org>
	<006901caf283$60709930$2151cb90$%kim@samsung.com>
Message-ID: <006a01caf28d$13e86bb0$3bb94310$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, May 13, 2010 12:02 PM Kukjin Kim wrote:

> Ben Dooks wrote:
> >
> > I would like to get an idea of what each group involvedi n the
> > current S5PC100 changes is planning to allow the organisation of
> > what is going on.
> >
> > Firstly, I think Kukjin's clock changes are the first to be
> > applied, followed by looking at what support exists (or is being
> > submitted) in plat-s5p which could be used for s5pc100.
> >
> > Then, let's move out what is left of plat-s5pc1xx into mach-s5pc100
> > and get rid of it (although the final removal may have to be left
> > until the next merge window, due to time constraints).
> >
> > I would like to see whatever changes done grouped into sections,
> > such as clock, machine, core, gpio.
> 
> I will re-submit S5PC100 clock patch which can be merged to Ben's latest
> tree
> without any compile error.
> 
> Marek, can you re-make your patches based on it?

Yes, I will do this soon.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
