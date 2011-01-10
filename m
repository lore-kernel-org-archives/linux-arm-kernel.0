From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 10 Jan 2011 14:34:34 +0100
Subject: [PATCH v4] ARM: mxs: Change duart device to use amba-pl011
In-Reply-To: <1294122052-18329-1-git-send-email-shawn.guo@freescale.com>
References: <1292857064-5032-1-git-send-email-shawn.guo@freescale.com>
	<1294122052-18329-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110110133434.GB31011@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 02:20:52PM +0800, Shawn Guo wrote:
> The mxs duart is actually an amba-pl011 device. This commit changes
> the duart device code to dynamically allocate amba-pl011 device,
> so that drivers/serial/amba-pl011.c can be used on mxs.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110110/ea3d0e4f/attachment-0001.sig>
