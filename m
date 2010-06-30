From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jun 2010 13:49:35 +0100
Subject: [PATCH] Versatile Express: add support for local timers on CA9X4
	daughterboard
In-Reply-To: <1275904430-15995-1-git-send-email-will.deacon@arm.com>
References: <1275904430-15995-1-git-send-email-will.deacon@arm.com>
Message-ID: <003801cb1852$b1e91ae0$15bb50a0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> [PATCH] Versatile Express: add support for local timers on CA9X4 daughterboard
> 
> This patch adds support for the Cortex-A9 local timers available when
> using the CA9X4 daughterboard with the Versatile Express.
> 
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/Kconfig                               |    5 +++--
>  arch/arm/mach-vexpress/ct-ca9x4.c              |   14 ++++++++------
>  arch/arm/mach-vexpress/include/mach/ct-ca9x4.h |    1 +
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 

Do you have any objections to this patch, or can I submit it to
the patch system please? There are some timer init functions
in ct-ca9x4.c that are commented out so I'd like to make sure
I'm not interfering with any future plans.

Thanks,

Will
