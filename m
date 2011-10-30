From: nikai@nikai.net (Nicolas Kaiser)
Date: Sun, 30 Oct 2011 10:23:31 +0100
Subject: [PATCH] [TRIVIAL] ARM: pxa: Fix typo
	'CONFIG_BACKLIGHT_PWM__MODULE'
In-Reply-To: <201110300035.27985.marek.vasut@gmail.com>
References: <1318347115.5754.3.camel@x61.thuisdomein>
	<alpine.LNX.2.00.1110292127320.3541@pobox.suse.cz>
	<201110300035.27985.marek.vasut@gmail.com>
Message-ID: <20111030102331.682dfd6e@absol.kitzblitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Vasut <marek.vasut@gmail.com>:
> > On Tue, 11 Oct 2011, Paul Bolle wrote:
> > > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > > ---
> > > Untested (I don't think I've got the hardware, nor have I got the
> > > toolchain at hand, etc.).
> > > 
> > >  arch/arm/mach-pxa/colibri-pxa270-income.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c
> > > b/arch/arm/mach-pxa/colibri-pxa270-income.c index 80538b8..248804b
> > > 100644
> > > --- a/arch/arm/mach-pxa/colibri-pxa270-income.c
> > > +++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
> > > @@ -183,7 +183,7 @@ static inline void income_lcd_init(void) {}
> > > 
> > >  /***********************************************************************
> > >  *******
> > >  
> > >   * Backlight
> > >   ***********************************************************************
> > >   *******/
> > > 
> > > -#if defined(CONFIG_BACKLIGHT_PWM) ||
> > > defined(CONFIG_BACKLIGHT_PWM__MODULE) +#if defined(CONFIG_BACKLIGHT_PWM)
> > > || defined(CONFIG_BACKLIGHT_PWM_MODULE)
> > > 
> > >  static struct platform_pwm_backlight_data income_backlight_data = {
> > >  
> > >  	.pwm_id		= 0,
> > >  	.max_brightness	= 0x3ff,
> > 
> > I'd like to have this at least compile-tested, adding some CCs.
> 
> The change is visually ok, add my:
> 
> Acked-by: Marek Vasut <marek.vasut@gmail.com>

I now remember you already acked this change last year:
https://lkml.org/lkml/2010/12/4/41

Sorry that I forgot to resend the patch.

Best regards,
Nicolas Kaiser
