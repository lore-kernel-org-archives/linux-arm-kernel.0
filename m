From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Feb 2013 13:31:02 +0100
Subject: [PATCH 3/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <1361968035-18644-4-git-send-email-mkl@pengutronix.de>
References: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
 <1361968035-18644-4-git-send-email-mkl@pengutronix.de>
Message-ID: <512DFC86.4090607@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2013 01:27 PM, Marc Kleine-Budde wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> This adds two little devicetree helper functions for determining the dr_mode
> (host, peripheral, otg, dual-role) and phy_type (utmi, ulpi,...) from the
> devicetree.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Felipe, same here. Your Acked-by is appreciated.

Marc
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/4c678f52/attachment.sig>
