From: devel@ayanes.com (Adrian Yanes)
Date: Wed, 09 May 2012 22:07:51 +0300
Subject: AW: [PATCH v10 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <D99582E5322435468A77E74BB0039E7B1D2293684D@SRV02.hamburg.garz-fricke.de>
References: <D99582E5322435468A77E74BB0039E7B1D22784CF0@SRV02.hamburg.garz-fricke.de>
 <alpine.DEB.2.00.1204261035060.16439@gatekeeper.vosshq.de>
 <D99582E5322435468A77E74BB0039E7B1D22784E8B@SRV02.hamburg.garz-fricke.de>
 <EF2E73589CA71846A15D0B2CDF79505D0905E0994A@wm021.weinmann.com>
 <D99582E5322435468A77E74BB0039E7B1D2293684D@SRV02.hamburg.garz-fricke.de>
Message-ID: <4FAAC087.7030304@ayanes.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Yes, our ECO920 uses the RM9200, but we support it with an very old kernel
>> (2.6.21). I remember there were many problems with I2C.

I really doubt this, as I indicated in a previous email[1], the RM9200
has a hardware "bug". So either you performed the testing with less than
2 bytes of data and in a really low frequency (<50kHz) or we are missing
something.

Can you provide more details about which kind of testing you performed?

Thanks

1 - http://article.gmane.org/gmane.linux.kernel/1287445/match=
