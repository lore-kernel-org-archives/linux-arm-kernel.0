From: marex@denx.de (Marek Vasut)
Date: Wed, 17 Jul 2013 19:05:30 +0200
Subject: [PATCH 2/2] ARM: dts: imx28: Adjust i2c interrupt bindings
In-Reply-To: <201305221219.43558.jbe@pengutronix.de>
References: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5AKKVeTMsXpG9wa-eeLocBStUwPjQEe3n6fRVY2aSc7Nw@mail.gmail.com>
 <201305221219.43558.jbe@pengutronix.de>
Message-ID: <201307171905.30981.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Juergen Beisert,

> Hi Fabio,
> 
> > i2c slowness is a different issue.
> 
> Same happens here for my i.M23 based platform. It seems the PIO mode does
> not work, or at least not like it works on a i.MX28. Each short transfer
> needs about one second (without an error message) but does not send
> anything on the I2C lines.
> 
> I need the following patches to make I2C master work within a 3.10-rc2
> kernel:
> 
> Subject: [PATCH] I2C/MXS: distinguish i.MX23 and i.MX28 based I2C
> controller Signed-off-by: Juergen Beisert <jbe@pengutronix.de>

Can you please properly submit this patch ?

Best regards,
Marek Vasut
