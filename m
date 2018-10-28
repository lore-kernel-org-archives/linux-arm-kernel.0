From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 28 Oct 2018 22:11:24 +0000
Subject: [PATCH v1 3/3] i2c: imx: don't print error if DMA is not
 configured
In-Reply-To: <20181018112615.29362-4-o.rempel@pengutronix.de>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
 <20181018112615.29362-4-o.rempel@pengutronix.de>
Message-ID: <20181028221123.GE1882@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 01:26:15PM +0200, Oleksij Rempel wrote:
> At least on i.MX5x variants is DMA event for I2C muxed with SDHC. So
> it is project specific configuration and not an error.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

So, the first patch is not I2C realm, and the second is dropped. No
comment about the third one?

And is maybe someone from Pengutronix interested in maintaining this
driver? Uwe maybe? That would speed up things for it...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181028/88739af1/attachment.sig>
