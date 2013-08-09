From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 09 Aug 2013 09:37:40 +0200
Subject: [PATCH RESEND] can: mcp251x: Replace power callbacks with
 regulator API
In-Reply-To: <1375963227-6468-1-git-send-email-shc_work@mail.ru>
References: <1375963227-6468-1-git-send-email-shc_work@mail.ru>
Message-ID: <52049C44.6030902@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 02:00 PM, Alexander Shiyan wrote:
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-pxa/icontrol.c         |  3 --
>  arch/arm/mach-pxa/zeus.c             | 46 ++++++++++----------

What's pxa's status of DT conversion? Do you (still) accept patches to
board files?

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
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130809/1e24b0f3/attachment.sig>
