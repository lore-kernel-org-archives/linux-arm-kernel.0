From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 19 Dec 2013 17:59:00 -0800
Subject: [PATCH Resend 01/10] clk: bcm2835: Remove duplicate inclusion of
 clk-provider.h
In-Reply-To: <CAK9yfHwSQd-Gd5dMPYib8FswdutkpaFxfpe2wezGh1Vu7pm7JQ@mail.gmail.com>
References: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
 <CAK9yfHwSQd-Gd5dMPYib8FswdutkpaFxfpe2wezGh1Vu7pm7JQ@mail.gmail.com>
Message-ID: <20131220015900.18119.89845@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sachin Kamat (2013-12-05 03:27:15)
> On 8 October 2013 16:47, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> > clk-provider.h was included twice.
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > ---
> > Added all the acquired acks to respective patches.
> > ---
> >  drivers/clk/clk-bcm2835.c |    1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/clk/clk-bcm2835.c b/drivers/clk/clk-bcm2835.c
> > index 5fb4ff5..676077d 100644
> > --- a/drivers/clk/clk-bcm2835.c
> > +++ b/drivers/clk/clk-bcm2835.c
> > @@ -20,7 +20,6 @@
> >  #include <linux/clk-provider.h>
> >  #include <linux/clkdev.h>
> >  #include <linux/clk/bcm2835.h>
> > -#include <linux/clk-provider.h>
> >  #include <linux/of.h>
> >
> >  static const struct of_device_id clk_match[] __initconst = {
> > --
> > 1.7.9.5
> >
> 
> Mike,
> 
> Any chance getting this series picked up?

Thanks for re-ping me on this! Taken into clk-next.

Regards,
Mike

> 
> -- 
> With warm regards,
> Sachin
