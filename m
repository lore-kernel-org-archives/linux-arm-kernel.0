From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 27 Aug 2012 15:54:30 -0300
Subject: [PATCH V4] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <1345779871-7677-1-git-send-email-marex@denx.de>
References: <1345779871-7677-1-git-send-email-marex@denx.de>
Message-ID: <CAOMZO5CSvP3nXNq4VLYALh+U9OZRnjtgXqTr7zsKdeHpUdJ4cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 12:44 AM, Marek Vasut <marex@denx.de> wrote:
> This patch implements DMA support into mxs-i2c. DMA transfers are now enabled
> via DT. The DMA operation is enabled by default.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: linux-i2c at vger.kernel.org
> CC: Shawn Guo <shawn.guo@linaro.org>
> Cc: Wolfram Sang <w.sang@pengutronix.de>

On a mx28evk:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Wolfram,

Adding dma support into mxs-i2c has also the benefit to allow i2c on
mx23 to work.

Please consider applying this one.

Thanks,

Fabio Estevam
