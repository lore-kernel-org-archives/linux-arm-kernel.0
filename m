From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 22 Nov 2012 22:40:56 +0100
Subject: [PATCH v3 0/3] i2c: at91: add dma support
In-Reply-To: <50ACA2D4.9040904@atmel.com>
References: <1352911493-6979-1-git-send-email-ludovic.desroches@atmel.com>
 <20121116170514.GA21903@pengutronix.de>
 <50ACA2D4.9040904@atmel.com>
Message-ID: <20121122214056.GC14851@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >Thanks, looks mostly good. I have problems applying patch 3. What is
> >this series based against?
> >
> 
> It was based against v3.7-rc4. Do you want me to rebase it against an
> over version?

That should be fine, but it still fails. The other patches apply, but
have offsets which is suspicious, too. Can you re-check, please?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/93751860/attachment.sig>
