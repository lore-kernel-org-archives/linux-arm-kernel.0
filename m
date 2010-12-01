From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Dec 2010 19:04:29 +0000
Subject: [PATCH] Kconfig: add new symbol MIGHT_HAVE_PCI
In-Reply-To: <20101201185103.GK32355@pengutronix.de>
References: <1291217412-9435-1-git-send-email-ulli.kroll@googlemail.com>
	<20101201185103.GK32355@pengutronix.de>
Message-ID: <20101201190429.GC29347@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 07:51:03PM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Dec 01, 2010 at 04:30:12PM +0100, Hans Ulli Kroll wrote:
> > Today more boards with arm cpu have selectable pci bus.
> > This patch makes this more scalable and remove line continuations in
> > Kconfig
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> > ---
> >  arch/arm/Kconfig                 |    7 ++++++-
> >  arch/arm/mach-cns3xxx/Kconfig    |    1 +
> >  arch/arm/mach-integrator/Kconfig |    1 +
> >  arch/arm/mach-ks8695/Kconfig     |    1 +
> >  arch/arm/mach-pxa/Kconfig        |    1 +
> >  arch/arm/mach-versatile/Kconfig  |    1 +
> >  6 files changed, 11 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index a19a526..614cf2f 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -34,6 +34,9 @@ config ARM
> >  config HAVE_PWM
> >  	bool
> >  
> > +config MIGHT_HAVE_PCI
> HAVE_PCI or HAS_PCI is a more usual name for this purpose.

This has been discussed in the thread "[PATCH] ARM: Gemini: Add support
for PCI Bus".
