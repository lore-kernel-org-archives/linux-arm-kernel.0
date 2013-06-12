From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Jun 2013 23:10:01 +0900
Subject: [PATCH 06/06] ARM: shmobile: Remove old SCU boot code
In-Reply-To: <20130610092025.18944.77279.sendpatchset@w520>
References: <20130610091925.18944.68117.sendpatchset@w520>
 <20130610092025.18944.77279.sendpatchset@w520>
Message-ID: <20130612141000.GW32751@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 06:20:25PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove shmobile_secondary_vector_scu now when all SCU enabled
> SMP platforms instead make use of shmobile_boot_scu. This
> removes two inline virtual to physical address conversions.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/headsmp-scu.S         |   22 +---------------------
>  arch/arm/mach-shmobile/include/mach/common.h |    1 -
>  2 files changed, 1 insertion(+), 22 deletions(-)

Thanks, I have queued this up for v3.11 in the (new) cleanup-boot branch.
