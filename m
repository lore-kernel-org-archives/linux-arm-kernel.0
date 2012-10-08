From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 8 Oct 2012 11:25:30 +0200
Subject: [PATCH V4] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <1345779871-7677-1-git-send-email-marex@denx.de>
References: <1345779871-7677-1-git-send-email-marex@denx.de>
Message-ID: <20121008092530.GA22051@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 05:44:31AM +0200, Marek Vasut wrote:
> This patch implements DMA support into mxs-i2c. DMA transfers are now enabled
> via DT. The DMA operation is enabled by default.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Thanks, applied to -next.

I am meanwhile thinking the driver needs massive changes, probably
dropping PIOQUEUE entirely. This is probably best done via incremental
patches to this one. I have sketches which were sadly not ready for this
merge-window :(

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121008/2e129d13/attachment.sig>
