From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Jul 2013 10:14:05 +0900
Subject: [PATCH 04/04] ARM: shmobile: Remove unused mach/dma.h
In-Reply-To: <20130709104016.1891.68682.sendpatchset@w520>
References: <20130709103944.1891.67462.sendpatchset@w520>
 <20130709104016.1891.68682.sendpatchset@w520>
Message-ID: <20130710011404.GO32603@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 07:40:16PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove mach-shmobile mach/dma.h since it only
> seems to be used on non-mach-shmobile platforms.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/include/mach/dma.h |    1 -
>  1 file changed, 1 deletion(-)

Thanks, I have queued this up for v3.12 in the cleanup branch.
It should appear in renesas-next-20130710
