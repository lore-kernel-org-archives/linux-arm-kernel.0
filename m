From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 7 Sep 2015 10:08:18 +0200
Subject: [PATCH 2/3] gpiolib: gpiod_hog remove separate name argument
In-Reply-To: <1439979512-3894-3-git-send-email-mpa@pengutronix.de>
References: <1439979512-3894-1-git-send-email-mpa@pengutronix.de>
 <1439979512-3894-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20150907080818.GQ9999@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 12:18:31PM +0200, Markus Pargmann wrote:
> From: Markus Pargmann <mpa@devmp.org>
> 
> The gpio name is now stored in the gpio descriptor, so we can simply use

What is now? Does this introduce a dependency; maybe better reference a
commit here?

> that instead of an argument to the function.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
