From: b32955@freescale.com (Huang Shijie)
Date: Fri, 28 Mar 2014 17:26:47 +0800
Subject: [PATCHv2 1/1] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <20140328090023.GB17250@pengutronix.de>
References: <1395399017-19005-1-git-send-email-LW@KARO-electronics.de>
 <20140324095902.GB11377@localhost> <20140326095156.3e5585b8@ipc1.ka-ro>
 <5332AEE7.2040402@freescale.com> <20140326125502.0e8d0657@ipc1.ka-ro>
 <20140327095956.GA29623@localhost> <20140327132109.06258526@ipc1.ka-ro>
 <5334D9F7.2030001@freescale.com> <20140328091646.1ce03f90@ipc1.ka-ro>
 <53353524.9020605@freescale.com> <20140328090023.GB17250@pengutronix.de>
Message-ID: <53354057.6030004@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?03?28? 17:00, Sascha Hauer ??:
> - disables swapping of BB marks in the FCB the ROM won't swap bytes.
We can not disable the swapping in the FCB in the imx28.
The DISBBM bit in the FCB does _NOT_ exit in the imx28's FCB.


thanks
Huang Shijie
