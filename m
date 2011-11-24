From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 24 Nov 2011 08:41:46 +0100
Subject: [PATCH v7 0/3] ARM: mxs: add recording support for saif
In-Reply-To: <20111124074619.GJ17979@S2100-06.ap.freescale.net>
References: <a> <1321977265-14959-1-git-send-email-b29396@freescale.com>
 <20111124073605.GI17979@S2100-06.ap.freescale.net>
 <20111124074619.GJ17979@S2100-06.ap.freescale.net>
Message-ID: <20111124074146.GT19986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 03:46:20PM +0800, Shawn Guo wrote:
> On Thu, Nov 24, 2011 at 03:36:05PM +0800, Shawn Guo wrote:
> > During the testing, the saif driver's dependency on
> > REGULATOR_FIXED_VOLTAGE was found.  I guess it should be resolved
> > in sound/soc/mxs/Kconfig rather than leaving it to users.
> > 
> Also SND_SOC_MXS_SGTL5000 should probably depends on I2C_MXS than I2C.
Hmm, I think it's common and accepted that an i2c device doesn't depend
on an i2c bus driver. In this case it's quite probable that you want
I2C_MXS, but technically you could also use I2C_GPIO.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
