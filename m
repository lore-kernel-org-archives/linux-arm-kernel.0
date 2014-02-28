From: marex@denx.de (Marek Vasut)
Date: Fri, 28 Feb 2014 13:00:30 +0100
Subject: [PATCH 1/3] i2c: add DMA support for freescale i2c driver
In-Reply-To: <20140228115925.5fe07693@ipc1.ka-ro>
References: <1393481115-22136-1-git-send-email-yao.yuan@freescale.com>
 <201402281004.10238.marex@denx.de> <20140228115925.5fe07693@ipc1.ka-ro>
Message-ID: <201402281300.30907.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 28, 2014 at 11:59:25 AM, Lothar Wa?mann wrote:
> Hi,
> 
> Marek Vasut wrote:
> > On Friday, February 28, 2014 at 06:19:18 AM, Yao Yuan wrote:
> > 
> > [...]
> > 
> > > Yes, here have two dma channels, one for RX and the other one for TX.
> > > When we request the channel we should determine it for TX or RX.
> > 
> > Sorry, I don't quite understand this. If you have two DMA channels, can
> > you not use them both to do full-duplex SPI transfer ?
> 
> SPI != I2C

You got me, sorry.

Best regards,
Marek Vasut
