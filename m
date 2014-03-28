From: b32955@freescale.com (Huang Shijie)
Date: Fri, 28 Mar 2014 10:09:59 +0800
Subject: [PATCHv2 1/1] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <20140327132109.06258526@ipc1.ka-ro>
References: <532BCFCC.4080205@freescale.com>	<1395399017-19005-1-git-send-email-LW@KARO-electronics.de>	<20140324095902.GB11377@localhost>	<20140326095156.3e5585b8@ipc1.ka-ro>	<5332AEE7.2040402@freescale.com>	<20140326125502.0e8d0657@ipc1.ka-ro>	<20140327095956.GA29623@localhost>
 <20140327132109.06258526@ipc1.ka-ro>
Message-ID: <5334D9F7.2030001@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?03?27? 20:21, Lothar Wa?mann ??:
> I can assure you that the>100.000 i.MX28 based modules, that we sold
> up to now boot from NAND just fine without any block mark swapping in
> the U-Boot pages.
>
Our driver should follow the Reference manual, not the product.

thanks
Huang Shijie
