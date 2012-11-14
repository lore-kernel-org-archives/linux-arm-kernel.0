From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 14 Nov 2012 13:04:00 +0100
Subject: [PATCHv3 0/7] i2c: omap: updates
In-Reply-To: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121114120400.GH5954@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 05:53:35PM +0530, Shubhrajyoti D wrote:

> Shubhrajyoti D (8):
>       i2c: omap: Fix the revision register read
>       i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207
>       i2c: omap: remove the dtrev
>       ARM: i2c: omap: Remove the i207 errata flag
>       i2c: omap: re-factor omap_i2c_init function
>       i2c: omap: make reset a seperate function
>       i2c: omap: Restore i2c context always
>       i2c: omap: cleanup the sysc write

Pushed the series to for-next, after fixing a trivial merge conflict
caused by reverting the QoS patch.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/fb4f6fd7/attachment.sig>
