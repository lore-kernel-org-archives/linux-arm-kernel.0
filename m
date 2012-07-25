From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 25 Jul 2012 13:05:33 +0200
Subject: [PATCH] ARM: mxs: enable ocotp on imx23 and imx28
In-Reply-To: <1342993697-25875-1-git-send-email-mkl@pengutronix.de>
References: <1342993697-25875-1-git-send-email-mkl@pengutronix.de>
Message-ID: <500FD2FD.9050200@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2012 11:48 PM, Marc Kleine-Budde wrote:
> This patch adds ocotp support to imx23 and imx28, a dt-only kernel fails
> to link with this error message otherwise:
> 
> arch/arm/mach-mxs/mach-mxs.c:169: undefined reference to `mxs_get_ocotp'
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello Shawn,
> 
> this applies to your "mxs/dt-for-3.6" tree. According to the datasheet
> both processors have a ocotp unit. Hope it alright to select the OCOTP
> on both imx23 and imx28.

ping

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
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120725/8955a5a5/attachment-0001.sig>
