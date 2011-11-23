From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 23 Nov 2011 11:58:21 +0100
Subject: [PATCH] IMX/SDMA : save the real count for one DMA transaction.
In-Reply-To: <1322039585-7901-1-git-send-email-b32955@freescale.com>
References: <1322039585-7901-1-git-send-email-b32955@freescale.com>
Message-ID: <20111123105821.GC4063@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +	/* save the real count we received or transmitted. */
> +	chan->private = (void *)count;

And if someone later needs another variable which is private?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111123/f7f9bd81/attachment.sig>
