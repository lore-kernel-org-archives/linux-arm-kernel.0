From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 13 Jul 2012 10:07:41 +0200
Subject: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <1341850974-11977-1-git-send-email-marex@denx.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
Message-ID: <20120713080741.GE32184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 06:22:53PM +0200, Marek Vasut wrote:
> This patch configures the I2C bus timing registers according
> to information passed via DT. Currently, 100kHz and 400kHz
> modes are supported.
> 
> The TIMING2 register value is wrong in the documentation for
> i.MX28! This was found and fixed by:
>   Shawn Guo <shawn.guo@linaro.org>
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to next, thanks.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120713/87880d65/attachment.sig>
