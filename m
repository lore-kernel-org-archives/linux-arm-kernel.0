From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 12 Jan 2012 10:42:45 +0100
Subject: mxs-auart serial driver DMA support?
In-Reply-To: <4F0E7EB0.2060906@bluegiga.com>
References: <4F0E7EB0.2060906@bluegiga.com>
Message-ID: <20120112094244.GA2775@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Any plans to add DMA support for mxs-auart serial driver? I noticed
> it is impossible to archive full 3.25 Mbs speed with current one.

No plans from our side, currently.

> As I understood porting DMA support from freescale's driver is not
> trivial because MXS DMA implementation has been changed to mainline
> version.

Yes, luckily. DMAENGINE is really the way to go.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120112/267d55f1/attachment.sig>
