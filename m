From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Jan 2010 17:13:12 +0100
Subject: decompression stopped printing dots (Uncompressing Linux...)
Message-ID: <20100120161312.GC20271@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

since 

	e7db7b4 (arm: add support for LZO-compressed kernels)

I don't get visual feed-back anymore while decompressing the zImage.
Before I got a dot ('.') for each flush_output, now I only get
"Uncompressing Linux..." and a few seconds later "done".

Was this intended?  I really prefer seeing the decompressor work.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
