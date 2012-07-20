From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 20 Jul 2012 12:14:27 +0200
Subject: [PATCH] usb: chipidea: ci13xxx-imx: remove global struct
In-Reply-To: <20120719132056.GB7630@pengutronix.de>
References: <20120718233107.GA32622@pengutronix.de>
 <20120719082856.GB11782@pengutronix.de>
 <20120719132056.GB7630@pengutronix.de>
Message-ID: <20120720101427.GB28180@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Actually i am touching two thing at a time in this patch, removing the
> static struct and setting the flags by oftree. I will resend this patch,
> together with other work, and will just leave the flags as currently
> set.

Yup. Might be worth splitting up this patch into two, as well.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120720/08c0e13a/attachment.sig>
