From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 03 Nov 2014 17:24:15 +0100
Subject: [PATCH 1/7] can: m_can: fix possible sleep in napi poll
In-Reply-To: <1414579527-31100-1-git-send-email-b29396@freescale.com>
References: <1414579527-31100-1-git-send-email-b29396@freescale.com>
Message-ID: <5457AC2F.3010200@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2014 11:45 AM, Dong Aisheng wrote:
> The m_can_get_berr_counter function can sleep and it may be called in napi poll function.
> Rework it to fix the following warning.

Applied to can/master.

Thanks, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/54138806/attachment.sig>
