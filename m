From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 28 Feb 2014 11:59:25 +0100
Subject: [PATCH 1/3] i2c: add DMA support for freescale i2c driver
In-Reply-To: <201402281004.10238.marex@denx.de>
References: <1393481115-22136-1-git-send-email-yao.yuan@freescale.com>
 <201402272139.36076.marex@denx.de>
 <3f58a8abdda74100b4f7b14d0c31c90e@BL2PR03MB338.namprd03.prod.outlook.com>
 <201402281004.10238.marex@denx.de>
Message-ID: <20140228115925.5fe07693@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Marek Vasut wrote:
> On Friday, February 28, 2014 at 06:19:18 AM, Yao Yuan wrote:
> 
> [...]
> > Yes, here have two dma channels, one for RX and the other one for TX.
> > When we request the channel we should determine it for TX or RX.
> 
> Sorry, I don't quite understand this. If you have two DMA channels, can you not 
> use them both to do full-duplex SPI transfer ?
> 
SPI != I2C


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
