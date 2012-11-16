From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 16 Nov 2012 18:05:14 +0100
Subject: [PATCH v3 0/3] i2c: at91: add dma support
In-Reply-To: <1352911493-6979-1-git-send-email-ludovic.desroches@atmel.com>
References: <1352911493-6979-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20121116170514.GA21903@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

> Here is the third version taking into account your feedback.

Thanks, looks mostly good. I have problems applying patch 3. What is
this series based against?

> Patch 1/3 should go into v3.7.

No, not necessarily. It is not really a bugfix, and it is probably too
late in the cycle for compiler silencing. Ah well, I decide later.

BTW if you use --strict with checkpatch, it will tell you about the
space after casts :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/a5fb9f95/attachment.sig>
