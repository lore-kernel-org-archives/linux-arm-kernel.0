From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 8 Dec 2017 11:44:54 -0200
Subject: [PATCH] i2c: imx: Include the right GPIO header
In-Reply-To: <20171208133535.17562-1-linus.walleij@linaro.org>
References: <20171208133535.17562-1-linus.walleij@linaro.org>
Message-ID: <CAOMZO5AyCp-Jud2CTaOTDOtxOpBSyKBqD1rtnYxoLajOfezxCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 8, 2017 at 11:35 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> <linux/of_gpio.h> is not used in this file, by
> <linux/gpio/consumer.h> is.

s/by/but

>
> Someone is just lucky with their implicit includes.
>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Other than this nit:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
