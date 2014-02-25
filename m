From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 25 Feb 2014 00:36:28 -0800
Subject: [PATCH] clk: shmobile: div6: use proper description in kernel doc
In-Reply-To: <1592414.PQLaxVPFpz@avalon>
References: <1393271848-13313-1-git-send-email-wsa@the-dreams.de>
 <1592414.PQLaxVPFpz@avalon>
Message-ID: <20140225083628.22529.78265@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Laurent Pinchart (2014-02-24 11:59:49)
> Hi Wolfram,
> 
> Thank you for the patch.
> 
> On Monday 24 February 2014 20:57:11 Wolfram Sang wrote:
> > From: Wolfram Sang <wsa@sang-engineering.com>
> > 
> > These variable clocks have nothing to do with MSTP gating, probably a
> > copy&paste leftover.
> > 
> > Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Mike, could you please pick this up for v3.15 ?

Taken into clk-next!

Thanks,
Mike

> 
> > ---
> >  drivers/clk/shmobile/clk-div6.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/shmobile/clk-div6.c
> > b/drivers/clk/shmobile/clk-div6.c index aac4756..f065f69 100644
> > --- a/drivers/clk/shmobile/clk-div6.c
> > +++ b/drivers/clk/shmobile/clk-div6.c
> > @@ -23,7 +23,7 @@
> >  #define CPG_DIV6_DIV_MASK    0x3f
> > 
> >  /**
> > - * struct div6_clock - MSTP gating clock
> > + * struct div6_clock - CPG 6 bit divider clock
> >   * @hw: handle between common and hardware-specific interfaces
> >   * @reg: IO-remapped register
> >   * @div: divisor value (1-64)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
