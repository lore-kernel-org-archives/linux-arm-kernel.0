From: davem@davemloft.net (David Miller)
Date: Fri, 23 Nov 2012 14:30:33 -0500 (EST)
Subject: [PATCH] net/macb: GEM DMA configuration register update
In-Reply-To: <1353678541-26839-1-git-send-email-nicolas.ferre@atmel.com>
References: <1353678541-26839-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20121123.143033.141910826801165909.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Fri, 23 Nov 2012 14:49:01 +0100

> Add information to the DMA Configuration Register to
> maximize system performance:
> - rx/tx packet buffer full memory size
> - allow possibility to use INCR16 if supported
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied to net-next.
