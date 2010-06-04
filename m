From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 4 Jun 2010 08:55:00 +0200
Subject: [PATCH 1/3] pxa/colibri270: Fix typo in colibri_pxa270_flash
In-Reply-To: <20100604062701.GR2695@buzzloop.caiaq.de>
References: <1275613654-23918-1-git-send-email-marek.vasut@gmail.com>
	<20100604062701.GR2695@buzzloop.caiaq.de>
Message-ID: <201006040855.00216.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 4. ?ervna 2010 08:27:02 Daniel Mack napsal(a):
> On Fri, Jun 04, 2010 at 03:07:32AM +0200, Marek Vasut wrote:
> > Append colibri_pxa270_flash(_device). This was missing.
> 
> Hmm, Eric fixed this typo already when commiting (y)our last patch set.
> Did you pull his tree?

I think so ... maybe I forget to pull the recent set of changes, then ignore 
this patch.

Cheers
> 
> Daniel
> 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > ---
> > 
> >  arch/arm/mach-pxa/colibri-pxa270.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-pxa/colibri-pxa270.c
> > b/arch/arm/mach-pxa/colibri-pxa270.c index 96ce4ae..98673ac 100644
> > --- a/arch/arm/mach-pxa/colibri-pxa270.c
> > +++ b/arch/arm/mach-pxa/colibri-pxa270.c
> > @@ -99,7 +99,7 @@ static struct platform_device
> > colibri_pxa270_flash_device = {
> > 
> >  static void __init colibri_pxa270_nor_init(void)
> >  {
> > 
> > -	platform_device_register(&colibri_pxa270_flash);
> > +	platform_device_register(&colibri_pxa270_flash_device);
> > 
> >  }
> >  #else
> >  static inline void colibri_pxa270_nor_init(void) {}
