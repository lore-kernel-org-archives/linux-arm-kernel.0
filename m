From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 30 Jul 2012 10:18:15 +0200
Subject: [PATCH 07/25] gpio/gpio-omap.c: add a const qualifier
In-Reply-To: <1343034810-3386-8-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-8-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <50164347.1040600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 July 2012 11:13 AM, Uwe Kleine-K?nig wrote:
> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
>
> 	drivers/gpio/gpio-omap.c: In function 'omap_gpio_probe':
> 	drivers/gpio/gpio-omap.c:1060: warning: assignment discards qualifiers from pointer target type
>
> Signed-off-by: Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
> ---
Looks fine to me. Thanks

Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
