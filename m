From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Jul 2013 10:13:45 +0900
Subject: [PATCH 03/04] ARM: shmobile: No need to use INTC demux on r8a7740
In-Reply-To: <20130709104008.1891.17746.sendpatchset@w520>
References: <20130709103944.1891.67462.sendpatchset@w520>
 <20130709104008.1891.17746.sendpatchset@w520>
Message-ID: <20130710011344.GN32603@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 07:40:08PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Now when the r8a7740 code has been converted to make use of
> GIC instead of INTC for root interrupt controller it is
> possible to exclude the low level INTC demux function
> shmobile_handle_irq_intc from linking. 
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/Makefile |    1 -
>  1 file changed, 1 deletion(-)

Thanks, I have queued this up for v3.12 in the cleanup branch.
It should appear in renesas-next-20130710
