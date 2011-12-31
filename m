From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 31 Dec 2011 16:46:18 +0100
Subject: [PATCH] MTD/GPMI : select more modules for GPMI by default
In-Reply-To: <4EFEB968.2000905@freescale.com>
References: <1325220337-23165-1-git-send-email-b32955@freescale.com>
 <20111231054432.GE12182@S2100-06.ap.freescale.net>
 <4EFEA210.30606@freescale.com>
 <20111231072441.GF12182@S2100-06.ap.freescale.net>
 <4EFEB968.2000905@freescale.com>
Message-ID: <20111231154618.GB27544@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I do not like the GPMI depend on the MXS-DMA. It looks very strange
> when you do the "make menuconfig".

That doesn't change that it DOES depend on it :) (You can't use GPMI without
DMA, right?)

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111231/ed8a9016/attachment.sig>
