From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 25 May 2017 20:29:02 +0200
Subject: [PATCH v5 05/20] ARM: dts: efm32: Add generic compatible string
 for I2C EEPROM
In-Reply-To: <20170523133448.4794-6-javier@dowhile0.org>
References: <20170523133448.4794-1-javier@dowhile0.org>
 <20170523133448.4794-6-javier@dowhile0.org>
Message-ID: <20170525182902.irlm5zbgmbsosvq4@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, May 23, 2017 at 03:34:33PM +0200, Javier Martinez Canillas wrote:
> The at24 driver allows to register I2C EEPROM chips using different vendor
> and devices, but the I2C subsystem does not take the vendor into account
> when matching using the I2C table since it only has device entries.
> 
> But when matching using an OF table, both the vendor and device has to be
> taken into account so the driver defines only a set of compatible strings
> using the "atmel" vendor as a generic fallback for compatible I2C devices.
> 
> So add this generic fallback to the device node compatible string to make
> the device to match the driver using the OF device ID table.
> 
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>

Assuming the of-table patch is accepted this can have my:

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Otherwise I'm not convinced this is worth the churn.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
