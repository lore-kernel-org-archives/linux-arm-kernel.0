From: zbr@ioremap.net (Evgeniy Polyakov)
Date: Sun, 06 Oct 2013 17:32:55 +0400
Subject: [PATCH 1/2] w1-gpio: Detect of_gpio_error for first gpio
In-Reply-To: <1380633330-2534-1-git-send-email-mpa@pengutronix.de>
References: <1380633330-2534-1-git-send-email-mpa@pengutronix.de>
Message-ID: <117291381066375@web3j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



01.10.2013, 17:16, "Markus Pargmann" <mpa@pengutronix.de>:
> The first DT gpio is necessary for this driver, but errors returned for
> of_get_gpio are ignored.
>
> This patch adds a return value check for the first of_get_gpio.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Both patches look good, thank you

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
