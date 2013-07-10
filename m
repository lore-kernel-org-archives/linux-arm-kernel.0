From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Jul 2013 10:12:45 +0900
Subject: [PATCH 01/04] ARM: shmobile: No need to use INTC header on r8a7779
In-Reply-To: <20130709103952.1891.92697.sendpatchset@w520>
References: <20130709103944.1891.67462.sendpatchset@w520>
 <20130709103952.1891.92697.sendpatchset@w520>
Message-ID: <20130710011244.GL32603@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 07:39:52PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Now when the intc-irqpin driver is used for external
> IRQ pins on r8a7779 it possible to get rid of unused
> INTC headers mach/intc.h and linux/sh_intc.h.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up for v3.12 in the cleanup branch.
It should appear in renesas-next-20130710
