From: b32955@freescale.com (Huang Shijie)
Date: Tue, 11 Dec 2012 10:01:16 +0800
Subject: [PATCH] mtd: nand: gpmi: reset BCH earlier, too, to avoid NAND
 startup problems
In-Reply-To: <20121206095213.GA2589@pengutronix.de>
References: <1354740362-20412-1-git-send-email-w.sang@pengutronix.de>
 <50BFFFE8.8040002@freescale.com> <20121206095213.GA2589@pengutronix.de>
Message-ID: <50C693EC.7050702@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?12?06? 17:52, Wolfram Sang ??:
> The setup needs to be done properly to ensure a consistent state at the
> beginning, especially when somebody used the NAND before (ROM code,
> bootloader). Fixing the bootloader alone is not enough.
I tried to make some time to test it.
But i am too busy this week.
Anyway, let this patch get merged.

Acked-by: Huang Shijie <b32955@freescale.com>


thanks
Huang Shijie
