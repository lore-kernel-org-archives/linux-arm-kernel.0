From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Tue, 28 Aug 2012 17:32:52 +0200
Subject: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <503CDF48.5080201@atmel.com>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>
 <503CDF48.5080201@atmel.com>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EC3DB91@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

ludovic.desroches wrote on Tuesday, August 28, 2012 5:10 PM:
> > +static const struct platform_device_id twi_ip_type = {
> > +	/*
> > +	 * driver_data is 2 for SAM9261 compatible ip, see enum twi_ip_id in
> > +	 * drivers/i2c/busses/i2c-at91.c
> > +	 */
> > +	.driver_data	= 2,
> > +};
> > +
> >   static struct platform_device at91sam9261_twi_device = {
> >   	.name			= "i2c-gpio",
> >   	.id			= -1,
> > +	.id_entry		= &twi_ip_type,
> >   	.dev.platform_data	= &pdata,
> >   };
> >
> 
> [...]
> 
> You add the id_entry to the i2c-gpio device instead of at91_i2c device.

Oh! I'll post the complete series tomorrow.

Regards,
Niko
