From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 28 Nov 2012 11:38:49 +0100
Subject: [PATCHv2] i2c: omap: Remove the
 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE flag
In-Reply-To: <1353923711-9615-1-git-send-email-shubhrajyoti@ti.com>
References: <1353923711-9615-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121128103849.GA14238@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 03:25:11PM +0530, Shubhrajyoti D wrote:
> The OMAP_I2C_FLAG_RESET_REGS_POSTIDLE is not used anymore
> in the i2c driver. Remove the flag.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Trivial enough to still go into 3.8. Applied to -next, thanks!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121128/1893610c/attachment.sig>
