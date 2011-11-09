From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 9 Nov 2011 22:46:03 +0100
Subject: [PATCH v2] ARM: mx28evk: Simplify GPIO requests for
 mx28evk_fec_reset
In-Reply-To: <1320870998-6200-1-git-send-email-festevam@gmail.com>
References: <1320870998-6200-1-git-send-email-festevam@gmail.com>
Message-ID: <20111109214603.GA6316@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2011 at 06:36:38PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Simplify GPIO requests inside mx28evk_fec_reset by using gpio_request_array.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Like it: Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111109/b4aa0ae2/attachment-0001.sig>
