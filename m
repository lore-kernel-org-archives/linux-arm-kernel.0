From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 31 Jul 2013 20:43:11 -0400
Subject: [PATCH 10/18] ARM: OMAP2+: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-11-git-send-email-sboyd@codeaurora.org>
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
 <1375309877-16617-11-git-send-email-sboyd@codeaurora.org>
Message-ID: <51F9AF1F.1060902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 31 July 2013 06:31 PM, Stephen Boyd wrote:
> The 32 bit sched_clock interface now supports 64 bits. Upgrade to
> the 64 bit function to allow us to remove the 32 bit registration
> interface.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/mach-omap2/timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
