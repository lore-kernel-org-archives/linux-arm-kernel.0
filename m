From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 14 Nov 2012 11:51:02 +0100
Subject: [PATCH] Revert "ARM: OMAP: convert I2C driver to PM QoS for MPU
 latency constraints"
In-Reply-To: <alpine.DEB.2.00.1211061619461.20573@utopia.booyaka.com>
References: <alpine.DEB.2.00.1211061619461.20573@utopia.booyaka.com>
Message-ID: <20121114105102.GD5954@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 04:31:32PM +0000, Paul Walmsley wrote:
> 
> This reverts commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc.

Here giving the patch name in parens would have really made sense.
Will fix that.

> This commit causes I2C timeouts to appear on several OMAP3430/3530-based
> boards:
> 
>   http://marc.info/?l=linux-arm-kernel&m=135071372426971&w=2
>   http://marc.info/?l=linux-arm-kernel&m=135067558415214&w=2
>   http://marc.info/?l=linux-arm-kernel&m=135216013608196&w=2
> 
> and appears to have been sent for merging before one of its prerequisites
> was merged:
> 
>   http://marc.info/?l=linux-arm-kernel&m=135219411617621&w=2

Hmm, any ideas how to avoid such things in the future?

> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Applied to for-current, thanks!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/51cce6bc/attachment.sig>
