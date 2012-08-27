From: adrian.yanes@aalto.fi (Yanes Martinez Adrian)
Date: Mon, 27 Aug 2012 10:40:37 +0000
Subject: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <503B4919.6080306@atmel.com>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>,
 <503B4919.6080306@atmel.com>
Message-ID: <BC0F374A1C27184AB96177CDFEC2F54225ECC330@EXMDB06.org.aalto.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

>Tested on at91rm9200, at91sam9261, at91sam9g20 and at91sam9m10 with
>eeprom, temperature sensor and rtc devices (and wolfson chip for
>sam9g20).

concerning the at91rm9200, what was the amount of bytes you transmitted?

Some months ago I performed some testing[1] with the previous version of
the patch and the main conclusion was that the absence of PDC in the
AT91RM9200 made this driver unusable in such platform.

Please double check this.

Thanks in advance,

Adrian.

1 - http://thread.gmane.org/gmane.linux.drivers.i2c/10367/focus=1287445
