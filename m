From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2012 12:39:54 +0000
Subject: [PATCH 0/7] share sa1100 rtc driver to arch-mmp
In-Reply-To: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <201202221239.54321.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 February 2012, Haojian Zhuang wrote:
> Remove the hardcode definition of rtc registers, use ioremap() instead.
> Append clk support for arch-mmp, so add dummy clk in arch-sa1100/arch-pxa.

What is the status of the drivers/rtc/rtc-pxa.c driver after this series?
Is is still required for some pxa machines or can it get removed now?
It seems a little strange to register two platform devices for the
rtc on each pxa machine, with the same resources.

	Arnd
