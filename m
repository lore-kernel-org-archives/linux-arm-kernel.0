From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 7 Sep 2015 10:05:54 +0200
Subject: [PATCH 1/3] gpio: Use __gpiod_request directly
In-Reply-To: <1439979512-3894-2-git-send-email-mpa@pengutronix.de>
References: <1439979512-3894-1-git-send-email-mpa@pengutronix.de>
 <1439979512-3894-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20150907080554.GP9999@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 12:18:30PM +0200, Markus Pargmann wrote:
> From: Markus Pargmann <mpa@devmp.org>
> 
> There is no reason to find out chip and hwnum to use to request a gpio
> and get another gpio descriptor. We already have the descriptor we want
> to use so we can directly use it.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
