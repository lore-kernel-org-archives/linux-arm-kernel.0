From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 12 Dec 2017 23:33:26 +0100
Subject: [PATCH] i2c: imx: Include the right GPIO header
In-Reply-To: <20171208133535.17562-1-linus.walleij@linaro.org>
References: <20171208133535.17562-1-linus.walleij@linaro.org>
Message-ID: <20171212223326.i3qnws7qmz7it5fp@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 08, 2017 at 02:35:35PM +0100, Linus Walleij wrote:
> <linux/of_gpio.h> is not used in this file, by
> <linux/gpio/consumer.h> is.
> 
> Someone is just lucky with their implicit includes.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171212/0ef31c42/attachment-0001.sig>
