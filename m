From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 03 Nov 2014 18:02:15 +0100
Subject: [PATCH 1/7] can: m_can: fix possible sleep in napi poll
In-Reply-To: <1414579527-31100-1-git-send-email-b29396@freescale.com>
References: <1414579527-31100-1-git-send-email-b29396@freescale.com>
Message-ID: <5457B517.8030805@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Dong Aisheng,

the state of the patches are:

1: can/master + stable
2: can/mster
3: can/mster
4: can/master + stable
5: waiting for Oliver's opinion due to the user space change
6: waiting for your input
7: waiting for your input

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/1990263e/attachment.sig>
