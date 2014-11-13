From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 13 Nov 2014 11:04:56 +0100
Subject: [PATCH V4 1/3] can: add can_is_canfd_skb() API
In-Reply-To: <1415349914-9145-1-git-send-email-b29396@freescale.com>
References: <1415349914-9145-1-git-send-email-b29396@freescale.com>
Message-ID: <54648248.1020400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2014 09:45 AM, Dong Aisheng wrote:
> The CAN device drivers can use it to check if the frame to send is on
> CAN FD mode or normal CAN mode.

Applied patches 1 and 3.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/7bf986df/attachment.sig>
