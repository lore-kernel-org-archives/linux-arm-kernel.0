From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 16 Sep 2012 12:44:36 +0200
Subject: [PATCH V4] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <CAOMZO5CSvP3nXNq4VLYALh+U9OZRnjtgXqTr7zsKdeHpUdJ4cQ@mail.gmail.com>
References: <1345779871-7677-1-git-send-email-marex@denx.de>
 <CAOMZO5CSvP3nXNq4VLYALh+U9OZRnjtgXqTr7zsKdeHpUdJ4cQ@mail.gmail.com>
Message-ID: <20120916104436.GC933@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 03:54:30PM -0300, Fabio Estevam wrote:
> On Fri, Aug 24, 2012 at 12:44 AM, Marek Vasut <marex@denx.de> wrote:
> > This patch implements DMA support into mxs-i2c. DMA transfers are now enabled
> > via DT. The DMA operation is enabled by default.
> >
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: linux-i2c at vger.kernel.org
> > CC: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> 
> On a mx28evk:
> 
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks, may I ask what your tests were?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120916/ecd63a5b/attachment.sig>
