From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Sep 2013 15:43:36 +0200
Subject: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support
 to the LRADC driver
In-Reply-To: <201309101458.27604.jbe@pengutronix.de>
References: <1378713801-1182-1-git-send-email-jbe@pengutronix.de>
 <201309101022.36637.marex@denx.de> <201309101458.27604.jbe@pengutronix.de>
Message-ID: <201309101543.36724.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear J?rgen Beisert,

> Hi Marek,
> 
> On Tuesday 10 September 2013 10:22:36 Marek Vasut wrote:
> > > On Monday 09 September 2013 18:04:19 Marek Vasut wrote:
> > > > > Distinguish i.MX23 and i.MX28 at runtime and do the same for both
> > > > > SoC at least for the 4 wire touchscreen.
> > > > > 
> > > > > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> > > > > CC: linux-arm-kernel at lists.infradead.org
> > > > > CC: devel at driverdev.osuosl.org
> > > > > CC: Marek Vasut <marex@denx.de>
> > > > > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > > > > CC: Jonathan Cameron <jic23@cam.ac.uk>
> > > > 
> > > > This patch seems to combine two things -- register access rework AND
> > > > adjustment of the driver for MX23 touchscreen.
> > > 
> > > It reworks the register access to avoid the i.MX23/i.MX28 runtime
> > > decision all over the code again and again. This is what Dan has
> > > recommended in his comment.
> > 
> > Sure, but this change should be separated from fixing the touchscreen
> > support then.
> 
> Hmm, but there is no need to rework the register access until the i.MX23
> touchscreen support is added. So this patch does both at the same time.

Yeah, which is hard to review if you combine two patches into single one. I'm 
pretty sure you do understand this.

[...]

Best regards,
Marek Vasut
