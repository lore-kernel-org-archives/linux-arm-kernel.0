From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 29 Sep 2015 23:14:54 +0800
Subject: [PATCH v3 7/7] clocksource: cosmetic: Drop OF 'dependency' from
 symbols
In-Reply-To: <1443451758-22717-8-git-send-email-marc.zyngier@arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
 <1443451758-22717-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <560AAAEE.3060406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2015 10:49 PM, Marc Zyngier wrote:
> Seeing the 'of' characters in a symbol that is being called from
> ACPI seems to freak out people. So let's do a bit of pointless
> renaming so that these folks do feel at home.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/kernel/time.c                              | 2 +-
>   arch/arm/mach-omap2/timer.c                         | 4 ++--
>   arch/arm/mach-rockchip/rockchip.c                   | 2 +-
>   arch/arm/mach-shmobile/setup-r8a7779.c              | 2 +-
>   arch/arm/mach-shmobile/setup-rcar-gen2.c            | 2 +-
>   arch/arm/mach-spear/spear13xx.c                     | 2 +-
>   arch/arm/mach-sunxi/sunxi.c                         | 2 +-
>   arch/arm/mach-u300/core.c                           | 2 +-
>   arch/arm/mach-ux500/timer.c                         | 2 +-
>   arch/arm/mach-zynq/common.c                         | 2 +-
>   arch/arm64/kernel/time.c                            | 2 +-
>   arch/microblaze/kernel/setup.c                      | 2 +-
>   arch/mips/pistachio/time.c                          | 2 +-
>   arch/mips/ralink/clk.c                              | 2 +-
>   arch/nios2/kernel/time.c                            | 2 +-
>   arch/xtensa/kernel/time.c                           | 2 +-
>   drivers/clocksource/Makefile                        | 2 +-
>   drivers/clocksource/{clksrc-of.c => clksrc-probe.c} | 2 +-
>   include/linux/clocksource.h                         | 4 ++--
>   19 files changed, 21 insertions(+), 21 deletions(-)
>   rename drivers/clocksource/{clksrc-of.c => clksrc-probe.c} (97%)

Thanks for fixing my worrying of making ACPI depends on OF
in previous version, for patch 4/7 to patch 7/7,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
