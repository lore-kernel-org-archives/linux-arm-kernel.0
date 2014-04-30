From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 30 Apr 2014 14:25:29 +0800
Subject: [PATCH] ARM: imx: imx6q, Add i2c4 clock to the clock tree
In-Reply-To: <1398693282-5286-1-git-send-email-mpa@pengutronix.de>
References: <1398693282-5286-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140430062527.GC16727@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 03:54:42PM +0200, Markus Pargmann wrote:
> This clock was missing for imx6dl SoCs. This patch adds the missing
> clock so we can use i2c4.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

I've queued a patch which adds the clock in a slightly different way.

https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/soc&id=95dcc2093da280e5ee440d7b418997da4d9b9c01

Shawn
