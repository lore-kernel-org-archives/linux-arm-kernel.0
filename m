From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 31 Jan 2012 12:49:29 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <201201311237.33997.marek.vasut@gmail.com>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <4F27AA98.2090602@freescale.com>
 <20120131092412.GA2471@pengutronix.de>
 <201201311237.33997.marek.vasut@gmail.com>
Message-ID: <20120131114929.GN2471@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Actually it's not board specific. You can run various bootloaders or various 
> bootstrap tools on any of those boards. Though pdata seems ok for the default 
> case, maybe we should have a simple way to override this?

You mean you want to switch to/drop the BBT if you want to? On MX23,
this can be easily a very dangerous thing to do. What's the use case?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120131/2e6defcf/attachment.sig>
