From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 14 Jul 2011 03:04:11 +0000
Subject: [alsa-devel] [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000
	machine driver
In-Reply-To: <20110713155821.GL1928@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713155821.GL1928@pengutronix.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CE3AB@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: alsa-devel-bounces at alsa-project.org [mailto:alsa-devel-
> bounces at alsa-project.org] On Behalf Of Wolfram Sang
> Sent: Wednesday, July 13, 2011 11:58 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
> broonie at opensource.wolfsonmicro.com; u.kleine-koenig at pengutronix.de;
> lrg at ti.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [alsa-devel] [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000
> machine driver
> 
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> 
> No parameters here, drop it.
> 
> > +#include <linux/device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/fsl_devices.h>
> > +#include <linux/gpio.h>
> 
> The last three, too.
>
> > +	/* sgtl5000 does not support 512*rate when in 96000 fs */
> > +	rate = params_rate(params);
> 
> ...so this line can go.
> 
Updated.
Thanks.

Regards
Dong Aisheng
