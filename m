From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 8 Feb 2013 15:49:42 +0530
Subject: [PATCH] ARM: smp_twd: convert to use CLKSRC_OF init
In-Reply-To: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
References: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
Message-ID: <5114D13E.5020308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 February 2013 02:23 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Now that we have OF based init with CLKSRC_OF, convert smp_twd init
> function to use it and covert all callers of
> twd_local_timer_of_register.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

[..]

>   arch/arm/mach-omap2/timer.c         |    2 +-

For OMAP,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
