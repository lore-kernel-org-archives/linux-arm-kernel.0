From: davem@davemloft.net (David Miller)
Date: Sat, 11 Jun 2011 16:25:33 -0700 (PDT)
Subject: [PATCH v3 2/5] net: ep93xx_eth: pass struct device to DMA API
	functions
In-Reply-To: <b69ec17080017f62baaa94bc1d21960022dc7381.1307816881.git.mika.westerberg@iki.fi>
References: <a908e30a30247a07b2352002742f291d1df0eb18.1307816881.git.mika.westerberg@iki.fi>
	<a908e30a30247a07b2352002742f291d1df0eb18.1307816881.git.mika.westerberg@iki.fi>
	<b69ec17080017f62baaa94bc1d21960022dc7381.1307816881.git.mika.westerberg@iki.fi>
Message-ID: <20110611.162533.1598577745882301197.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mika Westerberg <mika.westerberg@iki.fi>
Date: Sat, 11 Jun 2011 21:39:55 +0300

> We shouldn't use NULL for any DMA API functions, unless we are dealing with
> ISA or EISA device. So pass correct struct dev pointer to these functions.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>

Applied.
