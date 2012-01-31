From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 31 Jan 2012 10:24:12 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <4F27AA98.2090602@freescale.com>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <20120130094610.GA15596@pengutronix.de>
 <4F2671C3.6000809@freescale.com>
 <20120130104428.GB15596@pengutronix.de>
 <4F267F21.1030204@freescale.com>
 <20120130114131.GC15596@pengutronix.de>
 <4F27AA98.2090602@freescale.com>
Message-ID: <20120131092412.GA2471@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What's about to add a module_param() to enable/disable the BBT for GPMI?
> What's your suggestion?

I'd make it board specific rather than a module parameter like most
other drivers seem to do.

Thanks,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120131/02747958/attachment.sig>
