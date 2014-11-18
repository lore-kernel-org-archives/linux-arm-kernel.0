From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 18 Nov 2014 21:40:40 +0100
Subject: [PATCH V5 1/2] can: m_can: fix not set can_dlc for remote frame
In-Reply-To: <1416308455-29134-1-git-send-email-b29396@freescale.com>
References: <1416308455-29134-1-git-send-email-b29396@freescale.com>
Message-ID: <546BAEC8.6010605@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2014 12:00 PM, Dong Aisheng wrote:
> The original code missed to set the cf->can_dlc in the RTR case, so add it.

Applied both patches. Let's see what David says to the CAN FD support.

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
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141118/fafd91d8/attachment.sig>
