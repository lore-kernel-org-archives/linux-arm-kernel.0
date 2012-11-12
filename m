From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 17:00:36 +0000
Subject: [PATCH 12/14] ARM: SPEAr3xx: shirq: simplify and move the shared
 irq multiplexor to DT
In-Reply-To: <CAOh2x=nJXVVjFmDFnTN_02PSG9hcDuXToRUzRMi5jwJqUFtgfw@mail.gmail.com>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
 <201211121509.45176.arnd@arndb.de>
 <CAOh2x=nJXVVjFmDFnTN_02PSG9hcDuXToRUzRMi5jwJqUFtgfw@mail.gmail.com>
Message-ID: <201211121700.36892.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 November 2012, viresh kumar wrote:
> On Mon, Nov 12, 2012 at 8:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sunday 11 November 2012, Viresh Kumar wrote:
> 
> >>  .../devicetree/bindings/arm/spear/shirq.txt        |  48 ++++
> >>  arch/arm/mach-spear3xx/include/mach/irqs.h         |  10 +-
> >>  arch/arm/mach-spear3xx/spear300.c                  | 103 -------
> >>  arch/arm/mach-spear3xx/spear310.c                  | 202 --------------
> >>  arch/arm/mach-spear3xx/spear320.c                  | 204 --------------
> >>  arch/arm/mach-spear3xx/spear3xx.c                  |   4 +
> >>  arch/arm/plat-spear/include/plat/shirq.h           |  35 +--
> >>  arch/arm/plat-spear/shirq.c                        | 305 +++++++++++++++++----
> >
> > I guess it would be nice to move this to drivers/irqchip/st-shirq.c now
> > that we have introduced that directory.
> 
> I was sure that i will get this one :)
> I wanted to, but was just trying the basic patch first :)
> 
> I would add another patch in this series as the last patch to move stuff
> out of plat :)

Ok, no problem. Do it later then.

	Arnd
