From: b32955@freescale.com (Huang Shijie)
Date: Thu, 6 Dec 2012 10:16:08 +0800
Subject: [PATCH] mtd: nand: gpmi: reset BCH earlier, too, to avoid NAND
 startup problems
In-Reply-To: <1354740362-20412-1-git-send-email-w.sang@pengutronix.de>
References: <1354740362-20412-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <50BFFFE8.8040002@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?12?06? 04:46, Wolfram Sang ??:
> correctly after warm rebooting, so the kernel could not find the UBI or
which Soc do you meet this issue? the mx23 or mx28?

It's bad news to me. I ever thought the BCH-reset-issue is gone.
I ever tested many times in mx28(> 10000 times) with freescale's uboot.

I guest you are not use the freescale's uboot. The uboot also will reset
the BCH/GPMI.


thanks
Huang Shijie
