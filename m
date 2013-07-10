From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Jul 2013 09:51:43 +0900
Subject: [PATCH] ARM: shmobile: Minor update for the Lager DT reference
 code
In-Reply-To: <20130708061646.25516.97272.sendpatchset@w520>
References: <20130708061646.25516.97272.sendpatchset@w520>
Message-ID: <20130710005143.GC32603@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 03:16:46PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the Lager DT reference code to get rid of the redundant
> irqchip header and also make lager_add_standard_devices() static.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against "renesas-next-20130704v2"
> 
>  arch/arm/mach-shmobile/board-lager-reference.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks, I have queued this up for v3.12 in the dt-lager branch.
It should appear in renesas-next-20130710
