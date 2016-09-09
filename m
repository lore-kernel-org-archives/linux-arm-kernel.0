From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 9 Sep 2016 14:28:16 +0800
Subject: [PATCH 1/2] ARM: clk-imx35: fix name for ckil clk
In-Reply-To: <20160909062034.tim2tzcihui6inoa@pengutronix.de>
References: <1473327022-8065-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160909061631.GI16911@tiger>
 <20160909062034.tim2tzcihui6inoa@pengutronix.de>
Message-ID: <20160909062816.GL16911@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 08:20:34AM +0200, Uwe Kleine-K?nig wrote:
> To += mturquette, sboyd
> 
> Hello Shawn, hello Michael, hello Stephen,
> 
> On Fri, Sep 09, 2016 at 02:16:31PM +0800, Shawn Guo wrote:
> > On Thu, Sep 08, 2016 at 11:30:21AM +0200, Uwe Kleine-K?nig wrote:
> > > This fixes
> > > 	[    0.000000] i.MX clk 82: register failed with -17
> > > because the name is duplicated.
> > > 
> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > 
> > I did not queue any clock patches for this cycle.  Can you please send
> > the patches directly to clock maintainers?
> 
> @shawnguo: Is this an ack?

Yes,

Acked-by: Shawn Guo <shawnguo@kernel.org>

> @mturquette, sboyd: should I resend? IMHO the first patch should go in
> soon.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
