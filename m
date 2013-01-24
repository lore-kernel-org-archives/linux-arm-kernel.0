From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 24 Jan 2013 11:13:56 +0100
Subject: [PATCH] i2c: at91: add of_device_id entry for at91rm9200
In-Reply-To: <5100E9A4.9020804@atmel.com>
References: <1354743732-11581-1-git-send-email-manabian@gmail.com>
 <20121218060232.GL23971@game.jcrosoft.org>
 <20130124072714.GH8364@nekote.pengutronix.de>
 <5100E9A4.9020804@atmel.com>
Message-ID: <20130124101356.GA12933@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> I didn't add this when I did the rework because there was no DT tree
> support for RM9200. The configuration for RM9200 IP is already in
> the driver and used for non DT platform so I think it makes sense to
> add this.

I agree. If it is usable for non-dt, it should be usable for dt. If it
makes sense is left to the user.

Interpreted Ludovic's comment as ack and applied to -next, thanks!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130124/d5e790cb/attachment.sig>
