From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 9 Oct 2015 12:07:40 +0200
Subject: [PATCH] can: at91: remove at91_can_data
In-Reply-To: <1444316167-25940-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1444316167-25940-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <561791EC.7050102@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2015 04:56 PM, Alexandre Belloni wrote:
> struct at91_can_data was used to pass a callback to the driver, allowing it
> to switch the transceiver on and off. As all at91 boards are now using DT,
> this is not used anymore, remove that structure.

One board was obviously not converted properly to DT. As I don't have to
board to test, I'll apply this patch.

Thanks,
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
Size: 455 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151009/f2d386db/attachment.sig>
