From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Aug 2016 09:23:00 +0200
Subject: [PATCH 06/10] reset: socfpga: add driver Kconfig option
In-Reply-To: <57BDBCB0.30607@opensource.altera.com>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
 <1472045342-7434-6-git-send-email-p.zabel@pengutronix.de>
 <57BDBCB0.30607@opensource.altera.com>
Message-ID: <1472109780.3032.20.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 24.08.2016, 10:26 -0500 schrieb Dinh Nguyen:
> Hi Philipp,
> 
> just a minor nit:
> 
> On 08/24/2016 08:28 AM, Philipp Zabel wrote:
> > Visible only if COMPILE_TEST is enabled, this allows to include the
> > driver in build tests.
> > 
> > Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  drivers/reset/Kconfig  | 6 ++++++
> >  drivers/reset/Makefile | 2 +-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 6ac631e..354e281 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -49,6 +49,12 @@ config RESET_PISTACHIO
> >  	help
> >  	  This enables the reset driver for ImgTec Pistachio SoCs.
> >  
> > +config RESET_SOCFPGA
> > +	bool "SoC FPGA Reset Driver" if COMPILE_TEST
> 
> Prefer to be "SoCFPGA", no space in between.
>
[...]
> 
> Otherwise,
> 
> Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>

Thank you, I'll fix this.

regards
Philipp
