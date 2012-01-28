From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 28 Jan 2012 08:01:32 +0100
Subject: [PATCH 3/3] ARM: at91/tc/clocksource: Add 32 bit variant to
 Timer Counter
In-Reply-To: <d1105b63fce5787a4717ca92ad35397923078e99.1326995849.git.nicolas.ferre@atmel.com>
References: <a311afe3c46da62f7a1e82d2fa933e24ad4eef7e.1326995849.git.nicolas.ferre@atmel.com>
 <d1105b63fce5787a4717ca92ad35397923078e99.1326995849.git.nicolas.ferre@atmel.com>
Message-ID: <20120128070132.GC705@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:05 Thu 19 Jan     , Nicolas Ferre wrote:
> Some SoC have a 32 bit variant of Timer Counter Blocks. We do not
> need the chaining of two 16 bit counters anymore for them.
> 
> The SoC nature is deduced from the device tree "compatible" string.
> For non-device-tree configurations, backward compatibility is maintained
> by using the default 16 bit counter configuration.
> 
> This patch addresses both the atmel_tclib and its user: tcb_clksrc
> clocksource.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
