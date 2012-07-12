From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 12 Jul 2012 14:21:09 +0200
Subject: [PATCHv11 5/6] i2c: omap: Correct I2C revision for OMAP3
In-Reply-To: <1340896292-12112-6-git-send-email-shubhrajyoti@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
 <1340896292-12112-6-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120712122109.GE2194@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 08:41:31PM +0530, Shubhrajyoti D wrote:
> From: Jon Hunter <jon-hunter@ti.com>
> 
> The OMAP3530 is based upon the same silicon as the OMAP3430 and so the I2C
> revision is the same for 3430 and 3530. However, the OMAP3630 device has the
> same I2C revision as OMAP4. Correct the revision definition to reflect this.
> 
> This patch is based on work done by Jon Hunter <jon-hunter@ti.com>
> Changes from his patch
> - Update OMAP_I2C_REV_ON_3430 also to reflect that it is same as 3530
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120712/3b5239b1/attachment.sig>
