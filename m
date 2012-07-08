From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 8 Jul 2012 13:22:55 +0200
Subject: [PATCH v3] i2c: imx: convert to use managed functions
In-Reply-To: <1338807865-5487-1-git-send-email-richard.zhao@freescale.com>
References: <1338776481-23710-1-git-send-email-richard.zhao@freescale.com>
 <1338807865-5487-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120708112255.GA18362@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2012 at 07:04:25PM +0800, Richard Zhao wrote:
> - convert to use devm_request_and_ioremap, devm_kzalloc, devm_clk_get,
>   devm_request_irq.
> - clean up unused variables.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Reviewed-by: Shubhrajyoti D <Shubhrajyoti@ti.com>

Thanks, applied to for-next.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120708/cff5f05e/attachment.sig>
