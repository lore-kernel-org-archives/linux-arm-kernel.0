From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 12 Jul 2012 14:18:57 +0200
Subject: [PATCHv11 1/6] i2c: omap: Optimise the remove code
In-Reply-To: <1340896292-12112-2-git-send-email-shubhrajyoti@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
 <1340896292-12112-2-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120712121857.GA2194@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 08:41:27PM +0530, Shubhrajyoti D wrote:
> The omap_i2c_remove function may not be needed after
> device exit so the memory could be freed.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Changed the title from "optimise" to "annotate" and pushed to next.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120712/ce7bebb4/attachment.sig>
