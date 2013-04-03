From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 03 Apr 2013 09:56:41 +0200
Subject: [PATCH 0/2] mmc: mxs-mmc: add cd-inverted and non-removeable
In-Reply-To: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
References: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
Message-ID: <515BE0B9.4010209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 04:02 PM, Marc Kleine-Budde wrote:
> Hello,
> 
> this patch add support for the cd-inverted and non-removeable property (as
> defined in devicetree/bindings/mmc/mmc.txt) to the mxs-mmc driver. Tested on a
> custom imx28 board.
> 
> This series applies to Chris Ball's cjb/mmc-next branch.

ping

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130403/5c9ccc69/attachment.sig>
