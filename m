From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 27 Jan 2011 15:40:18 +0100
Subject: [PATCH 06/11] ARM: realview: remove old AMBA device DMA
	definitions
In-Reply-To: <E1PiSCS-0003pD-3F@rmk-PC.arm.linux.org.uk>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
	<E1PiSCS-0003pD-3F@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTikThe5ZjVoRc5mVe7JmXeJkjE6JxJ7-zuYK6-2e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> The AMBA DMA macro definitions are not used, and the AMBA Primecell DMA
> support makes no use of them either, so they can be removed.

I've contemplated adding DMA channel info (one tx and one rx channel
should suffice for anything I've seen) and a filter function to
struct amba_device instead of having it as platform data selectively
for each PrimeCell as we have now.

I don't know if it's a good idea.

Yours,
Linus Walleij
