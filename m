From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 1 Apr 2012 11:21:25 +0200
Subject: mc13xxx: add I2C support, V5
In-Reply-To: <1333262499-25871-1-git-send-email-marc@cpdesign.com.au>
References: <1333262499-25871-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120401092125.GX15647@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Sun, Apr 01, 2012 at 04:41:35PM +1000, Marc Reilly wrote:
> This series (against mfd-2.6/for-next) changes the mc13xxx driver to use 
> regmap and adds I2C support.
> It has a compile dependency on regmap/for-next, as the spi driver uses the
> recently added pad_bits config field.
> 
> Patch 2/4 has:
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Patch 4/4 has:
> Signed-off-by: Oskar Schirmer <oskar@scara.com>
You didn't add these tags to the respective patches. (And I think
Signed-off-by: Oskar is wrong. Maybe this should be an Ack?)
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
