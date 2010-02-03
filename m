From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Feb 2010 21:56:09 +0100
Subject: [PATCH] MX1/MX2: -EINVAL overwritten in second iteration in
	mxc_gpio_setup_multiple_pins()
In-Reply-To: <4B69CC24.3050503@gmail.com>
References: <4B69CC24.3050503@gmail.com>
Message-ID: <20100203205609.GG20113@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 08:19:00PM +0100, Roel Kluin wrote:
> Due to the `ret = gpio_request()' below in the loop, the initial -EINVAL value
> of ret is overwritten. 
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

> ---
> Not 100% sure this is needed, please review. One more question: is it ok
> to return 0 when count is 0 (and nothing is done)?
I'd say yes.  If you want nothing from me, I can say I gave you all you
wanted without doing anything.

Thanks
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
