From: davem@davemloft.net (David Miller)
Date: Sat, 11 Jun 2011 16:25:25 -0700 (PDT)
Subject: [PATCH v3 1/5] ep93xx: set DMA masks for the ep93xx_eth
In-Reply-To: <a908e30a30247a07b2352002742f291d1df0eb18.1307816881.git.mika.westerberg@iki.fi>
References: <a908e30a30247a07b2352002742f291d1df0eb18.1307816881.git.mika.westerberg@iki.fi>
Message-ID: <20110611.162525.724377461693377896.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mika Westerberg <mika.westerberg@iki.fi>
Date: Sat, 11 Jun 2011 21:39:54 +0300

> Since the driver uses the DMA API, we should pass it valid DMA masks.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Tested-by: Petr Stetiar <ynezz@true.cz>

Applied.
