From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Jun 2013 23:09:52 +0900
Subject: [PATCH 04/06] ARM: shmobile: sh73a0 SMP with SCU boot fn and args
In-Reply-To: <20130610092006.18944.71343.sendpatchset@w520>
References: <20130610091925.18944.68117.sendpatchset@w520>
 <20130610092006.18944.71343.sendpatchset@w520>
Message-ID: <20130612140951.GU32751@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 06:20:06PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Let sh73a0 make use of shmobile_boot_fn and shmobile_boot_arg
> together with shmobile_boot_scu and the SCU base address.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/smp-sh73a0.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Thanks, I have queued this up for v3.11 in the (new) cleanup-boot branch.
