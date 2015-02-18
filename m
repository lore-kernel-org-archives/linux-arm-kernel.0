From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Feb 2015 21:37:48 +0100
Subject: [PATCH] ARM: make of_device_ids const
In-Reply-To: <1424290796-18475-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424290796-18475-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <6700107.3fSsY2uIcW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 February 2015 21:19:56 Uwe Kleine-K?nig wrote:
> of_device_ids (i.e. compatible strings and the respective data) are not
> supposed to change at runtime. All functions working with of_device_ids
> provided by <linux/of.h> work with const of_device_ids. So mark the
> non-const structs in arch/arm as const, too.
> 
> While at it also add some __initconst annotations.
> 
> Acked-by: Jason Cooper <jason@lakedameon.net>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied to fixes branch, thanks!

	Arnd
