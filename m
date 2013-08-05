From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 05 Aug 2013 15:03:17 -0700
Subject: [PATCH] clk: mxs: clk-imx23: Include <linux/clk/mxs.h>
In-Reply-To: <20130717035125.GD4541@S2101-09.ap.freescale.net>
References: <1373981623-23800-1-git-send-email-fabio.estevam@freescale.com>
 <20130717035125.GD4541@S2101-09.ap.freescale.net>
Message-ID: <20130805220317.5348.681@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Shawn Guo (2013-07-16 20:51:27)
> On Tue, Jul 16, 2013 at 10:33:43AM -0300, Fabio Estevam wrote:
> > Fix the following sparse warning:
> > 
> > drivers/clk/mxs/clk-imx23.c:102:12: warning: symbol 'mx23_clocks_init' was not declared. Should it be static?
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Taken into clk-next.

Thanks!
Mike

> 
> > ---
> >  drivers/clk/mxs/clk-imx23.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
> > index f6a7487..c396fe3 100644
> > --- a/drivers/clk/mxs/clk-imx23.c
> > +++ b/drivers/clk/mxs/clk-imx23.c
> > @@ -10,6 +10,7 @@
> >   */
> >  
> >  #include <linux/clk.h>
> > +#include <linux/clk/mxs.h>
> >  #include <linux/clkdev.h>
> >  #include <linux/err.h>
> >  #include <linux/init.h>
> > -- 
> > 1.8.1.2
> > 
> >
