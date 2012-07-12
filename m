From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 12 Jul 2012 14:19:28 +0200
Subject: [PATCHv11 3/6] i2c: omap: Do not initialise the completion
 everytime
In-Reply-To: <1340896292-12112-4-git-send-email-shubhrajyoti@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
 <1340896292-12112-4-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120712121928.GC2194@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 08:41:29PM +0530, Shubhrajyoti D wrote:
> Use INIT_COMPLETION instead of init_completion in transfer.
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120712/a025b696/attachment.sig>
