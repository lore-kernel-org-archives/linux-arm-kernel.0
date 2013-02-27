From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Feb 2013 13:29:40 +0100
Subject: [PATCH 2/9] USB: move bulk of otg/otg.c to phy/phy.c
In-Reply-To: <1361968035-18644-3-git-send-email-mkl@pengutronix.de>
References: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
 <1361968035-18644-3-git-send-email-mkl@pengutronix.de>
Message-ID: <512DFC34.30000@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2013 01:27 PM, Marc Kleine-Budde wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Most of otg/otg.c is not otg specific, but phy specific, so move it
> to the phy directory.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Reported-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Felipe, can you please review this patch and give us your Acked-by?

regards, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/03bd19d0/attachment.sig>
