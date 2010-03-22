From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 22 Mar 2010 21:47:06 +0100
Subject: [PATCH 1/3] gpiolib: make names array and its values const
In-Reply-To: <1265620180-14150-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100203155558.GH11354@pengutronix.de>
	<1265620180-14150-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100322204706.GA10157@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Mon, Feb 08, 2010 at 10:09:38AM +0100, Uwe Kleine-K?nig wrote:
> gpiolib doesn't need to modify the names and I assume most initializers
> use sting constants that shouldn't be modified anyhow.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Kevin Wells <kevin.wells@nxp.com>
> ---
>  drivers/gpio/gpiolib.c      |    2 +-
>  drivers/gpio/pca953x.c      |    2 +-
>  include/asm-generic/gpio.h  |    2 +-
>  include/linux/i2c/pca953x.h |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

I haven't received feed back for these patches.  Would you care to take
them?  If yes, should I resend?  Alternatively you can get them from 

	git://git.pengutronix.de/git/ukl/linux-2.6.git gpiolib/names

whatever is easiest for you ...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
