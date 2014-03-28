From: b32955@freescale.com (Huang Shijie)
Date: Fri, 28 Mar 2014 17:33:18 +0800
Subject: [PATCHv2 1/1] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <20140328100158.042a3d68@ipc1.ka-ro>
References: <532BCFCC.4080205@freescale.com>	<1395399017-19005-1-git-send-email-LW@KARO-electronics.de>	<20140324095902.GB11377@localhost>	<20140326095156.3e5585b8@ipc1.ka-ro>	<5332AEE7.2040402@freescale.com>	<20140326125502.0e8d0657@ipc1.ka-ro>	<20140327095956.GA29623@localhost>	<20140327132109.06258526@ipc1.ka-ro>	<5334D9F7.2030001@freescale.com>	<20140328091646.1ce03f90@ipc1.ka-ro>	<53353524.9020605@freescale.com>
 <20140328100158.042a3d68@ipc1.ka-ro>
Message-ID: <533541DE.7020606@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?03?28? 17:01, Lothar Wa?mann ??:
> There is no need for the ROM code to access any other partition than
> the bootloader itself. Thus Linux can perfectly well be booted from
Assume the ROM only access the partition which contains the bootloader, and
the ROM does the swapping for the pages(but we do not do the swapping to 
these pages),

what will happen?



thanks
Huang Shijie
