From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Sep 2013 10:22:36 +0200
Subject: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support
 to the LRADC driver
In-Reply-To: <201309100936.14562.jbe@pengutronix.de>
References: <1378713801-1182-1-git-send-email-jbe@pengutronix.de>
 <201309091804.20177.marex@denx.de> <201309100936.14562.jbe@pengutronix.de>
Message-ID: <201309101022.36637.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear J?rgen Beisert,

> Hi Marek,
> 
> On Monday 09 September 2013 18:04:19 Marek Vasut wrote:
> > > Distinguish i.MX23 and i.MX28 at runtime and do the same for both SoC
> > > at least for the 4 wire touchscreen.
> > > 
> > > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> > > CC: linux-arm-kernel at lists.infradead.org
> > > CC: devel at driverdev.osuosl.org
> > > CC: Marek Vasut <marex@denx.de>
> > > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > > CC: Jonathan Cameron <jic23@cam.ac.uk>
> > 
> > This patch seems to combine two things -- register access rework AND
> > adjustment of the driver for MX23 touchscreen.
> 
> It reworks the register access to avoid the i.MX23/i.MX28 runtime decision
> all over the code again and again. This is what Dan has recommended in his
> comment.

Sure, but this change should be separated from fixing the touchscreen support 
then.

> > Btw the MX23 ADC was already supported,
> 
> No. This patch is the first in this series which brings in the specific
> register bits, because the ADC units in the i.MX23 and i.MX28 differ.
> 
> > so this "add i.MX23 support" commit message is not accurate.
> 
> Hmmm, what else do you think should I write?

You're just correcting the touchscreen support, no ?

Best regards,
Marek Vasut
