From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 11 Sep 2012 23:53:41 +0200
Subject: [PATCHv7 19/23] i2c: omap: always return IRQ_HANDLED
In-Reply-To: <1347356538-23835-20-git-send-email-shubhrajyoti@ti.com>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
 <1347356538-23835-20-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120911215341.GB27031@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 03:12:14PM +0530, Shubhrajyoti D wrote:
> From: Felipe Balbi <balbi@ti.com>
> 
> even if our clocks are disabled, we still
> handled the IRQ, so we should return IRQ_HANDLED.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Can't we just drop this patch since the code gets removed soon anyhow?
Or is patch 20/23 changing something I don't see yet?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120911/aed0208f/attachment.sig>
