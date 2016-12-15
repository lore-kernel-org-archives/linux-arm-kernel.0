From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 15 Dec 2016 08:57:57 +0100
Subject: [PATCH 8/8] Makefile: drop -D__CHECK_ENDIAN__ from cflags
In-Reply-To: <1481778865-27667-9-git-send-email-mst@redhat.com>
References: <1481778865-27667-1-git-send-email-mst@redhat.com>
 <1481778865-27667-9-git-send-email-mst@redhat.com>
Message-ID: <4b0172bd-2779-35b2-96af-407087db844e@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2016 06:15 AM, Michael S. Tsirkin wrote:
> That's the default now, no need for makefiles to set it.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
[...]
>  drivers/net/can/Makefile                                  | 1 -

For drivers/net/can/Makefile:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
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
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161215/0b31e486/attachment.sig>
