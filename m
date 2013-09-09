From: marex@denx.de (Marek Vasut)
Date: Mon, 9 Sep 2013 18:04:19 +0200
Subject: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support
 to the LRADC driver
In-Reply-To: <1378713801-1182-4-git-send-email-jbe@pengutronix.de>
References: <1378713801-1182-1-git-send-email-jbe@pengutronix.de>
 <1378713801-1182-4-git-send-email-jbe@pengutronix.de>
Message-ID: <201309091804.20177.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Juergen Beisert,

> Distinguish i.MX23 and i.MX28 at runtime and do the same for both SoC at
> least for the 4 wire touchscreen.
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> CC: linux-arm-kernel at lists.infradead.org
> CC: devel at driverdev.osuosl.org
> CC: Marek Vasut <marex@denx.de>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> CC: Jonathan Cameron <jic23@cam.ac.uk>

This patch seems to combine two things -- register access rework AND adjustment 
of the driver for MX23 touchscreen. Btw the MX23 ADC was already supported, so 
this "add i.MX23 support" commit message is not accurate.

Best regards,
Marek Vasut
