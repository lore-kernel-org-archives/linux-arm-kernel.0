From: jbe@pengutronix.de (Juergen Beisert)
Date: Mon, 9 Jul 2012 11:19:44 +0200
Subject: [PATCH] IIO: Add basic MXS LRADC driver
In-Reply-To: <1341368129-20468-1-git-send-email-marex@denx.de>
References: <1341368129-20468-1-git-send-email-marex@denx.de>
Message-ID: <201207091119.44952.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Marek Vasut wrote:
> This driver is very basic. It supports userland trigger, buffer and
> raw access to channels. The support for delay channels is missing
> altogether.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Juergen Beisert <jbe@pengutronix.de>
> ---
>  drivers/staging/iio/adc/Kconfig     |   12 +
>  drivers/staging/iio/adc/Makefile    |    1 +
>  drivers/staging/iio/adc/mxs-lradc.c |  619 +++++++++++++++++++++++++++++++++++
>  3 files changed, 632 insertions(+) 
>  create mode 100644 drivers/staging/iio/adc/mxs-lradc.c
>
> [...]

sorry for the delay, too much work at the same time. When I try to compile
your code I get:

drivers/staging/iio/adc/mxs-lradc.c:42:40: fatal error: linux/iio/triggered_buffer.h: No such file or directory

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
