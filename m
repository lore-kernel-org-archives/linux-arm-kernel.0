From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 30 Jan 2012 14:19:13 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <201201301324.13962.marek.vasut@gmail.com>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <20120130104428.GB15596@pengutronix.de>
 <4F267F21.1030204@freescale.com>
 <201201301324.13962.marek.vasut@gmail.com>
Message-ID: <20120130131913.GE15596@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The mainline incarnation of this should be able to work with the BBT just fine. 
> You can give it a go, mx28evk (the freescale kit) is supported.

Did you test? I can't find any NO_OOB option in the code. Not that you
lose the BBTs...

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120130/f91c6ea1/attachment.sig>
