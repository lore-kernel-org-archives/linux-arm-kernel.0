From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Sep 2010 12:50:18 +0200
Subject: [PATCH 16/19] ARM: nomadik: register nmk_gpio_driver using
	platform_driver_probe
In-Reply-To: <AANLkTin4XQWDdSjFaU-FsvVP43gUKffr-csKTvnxGQc7@mail.gmail.com>
References: <20100805140813.GA13859@pengutronix.de>
	<1281017333-5563-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTin4XQWDdSjFaU-FsvVP43gUKffr-csKTvnxGQc7@mail.gmail.com>
Message-ID: <20100902105018.GG14214@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On Thu, Sep 02, 2010 at 12:30:22PM +0200, Linus Walleij wrote:
> 2010/8/5 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> 
> > This fixes a section mismatch reported by modpost:
> 
> Uwe, why have you put this into Russells patch tracker without taking
> into account the issues raised by Rabin?
Oh sorry, overlooked that when resorting my patches.  Will send a fix
after lunch.

Best regards and thanks for noticing,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
