From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 25 Nov 2015 14:44:51 +0000
Subject: ARM: mach-dove: fix legacy get_irqnr_and_base
In-Reply-To: <alpine.LFD.2.20.1511222234010.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511222234010.22569@knanqh.ubzr>
Message-ID: <20151125144451.GZ6520@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 22, 2015 at 10:40:03PM -0500, Nicolas Pitre wrote:
> Commit 5d6bed2a9c ("ARM: dove: fix legacy dove IRQ numbers") shifted
> IRQ numbers by one but didn't update the get_irqnr_and_base macro
> accordingly.  This macro is involved when CONFIG_MULTI_IRQ_HANDLER
> is not defined.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Applied to mvebu/fixes with minor tweak to the subject line.  Also,
flagged for stable back to v4.2.

thx,

Jason.
