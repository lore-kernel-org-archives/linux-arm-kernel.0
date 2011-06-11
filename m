From: davem@davemloft.net (David Miller)
Date: Sat, 11 Jun 2011 16:25:40 -0700 (PDT)
Subject: [PATCH v3 3/5] net: ep93xx_eth: allocate buffers using kmalloc()
In-Reply-To: <511e0ae99e245fccb4692e7bb51944575f1b3287.1307816881.git.mika.westerberg@iki.fi>
References: <a908e30a30247a07b2352002742f291d1df0eb18.1307816881.git.mika.westerberg@iki.fi>
	<a908e30a30247a07b2352002742f291d1df0eb18.1307816881.git.mika.westerberg@iki.fi>
	<511e0ae99e245fccb4692e7bb51944575f1b3287.1307816881.git.mika.westerberg@iki.fi>
Message-ID: <20110611.162540.868268573517714775.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mika Westerberg <mika.westerberg@iki.fi>
Date: Sat, 11 Jun 2011 21:39:56 +0300

> We can use simply kmalloc() to allocate the buffers. This also simplifies the
> code and allows us to perform DMA sync operations more easily.
> 
> Memory is allocated with only GFP_KERNEL since there are no DMA allocation
> restrictions on this platform.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Tested-by: Petr Stetiar <ynezz@true.cz>

Applied.
