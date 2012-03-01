From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 09:51:46 +0000
Subject: [PATCH 1/8] gpio: pxa: add OF support
In-Reply-To: <201203010940.37123.arnd@arndb.de>
References: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
 <1330582228-12424-2-git-send-email-haojian.zhuang@marvell.com>
 <201203010940.37123.arnd@arndb.de>
Message-ID: <201203010951.46871.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Arnd Bergmann wrote:
> It seems that you are not following the regular IRQ binding. This should
> probably use irq_of_parse_and_map().

Or better platform_get_irq, see comment on rtc driver.

	Arnd
