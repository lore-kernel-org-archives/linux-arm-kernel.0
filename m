From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 15:42:36 +0100
Subject: [PATCH 16/19] ARM: nomadik: register nmk_gpio_driver using
	platform_driver_probe
In-Reply-To: <AANLkTin4XQWDdSjFaU-FsvVP43gUKffr-csKTvnxGQc7@mail.gmail.com>
References: <20100805140813.GA13859@pengutronix.de>
	<1281017333-5563-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTin4XQWDdSjFaU-FsvVP43gUKffr-csKTvnxGQc7@mail.gmail.com>
Message-ID: <20100902144236.GO26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 12:30:22PM +0200, Linus Walleij wrote:
> 2010/8/5 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> 
> > This fixes a section mismatch reported by modpost:
> 
> Uwe, why have you put this into Russells patch tracker without taking
> into account the issues raised by Rabin?

I've just discarded that fix - luckily I'd read the majority of list
traffic before starting to process some of the patch backlog, and
remembered this issue.
