From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 16 Aug 2010 15:47:01 +0200
Subject: [PATCH 1/4] clock-imx35: use get_3_3_div helper for
	get_rate_ipg_per
In-Reply-To: <4C693F2C.6060605@ru.mvista.com>
References: <1281964473-27484-1-git-send-email-m.grzeschik@pengutronix.de>
	<1281964473-27484-2-git-send-email-m.grzeschik@pengutronix.de>
	<4C693F2C.6060605@ru.mvista.com>
Message-ID: <4C694155.8070508@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote:
> Hello.
> 
> Michael Grzeschik wrote:
> 
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
>    So, who's the author of the patch? In case it's actually Marc, you
> should have added (at the start of the changelog):

Yeah, it's me.

> From: Marc Kleine-Budde <mkl@pengutronix.de>
or do a:
$(git commit --amend --author="Marc Kleine-Budde <mkl@pengutronix.de>")
on the patches..


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
Size: 260 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100816/f135c32a/attachment.sig>
