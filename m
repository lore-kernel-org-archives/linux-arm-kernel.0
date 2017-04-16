From: horms@verge.net.au (Simon Horman)
Date: Mon, 17 Apr 2017 08:12:23 +0900
Subject: [PATCH 2/2] arm64: Fix power-of-ten vs. power-of-two prefixes in
 comments etc.
In-Reply-To: <1492085938.20068.6.camel@infradead.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org>
 <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
 <20170404073504.GI16309@linaro.org>
 <1491291844.6218.25.camel@infradead.org>
 <20170404092604.GB14898@arm.com>
 <1492085938.20068.6.camel@infradead.org>
Message-ID: <20170416231223.GA31693@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Cc linux-renesas-soc]

On Thu, Apr 13, 2017 at 01:18:58PM +0100, David Woodhouse wrote:
> Less important than in user-visible messages, but still good practice as
> there's still no excuse for ARM64 code to look like it was written before
> 1996.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Hi David,

I'd be happy to take the Renesas portions of this change if they were
broken out into a separate patch. The reason I would prefer a separate
patch is to avoid the possibility of conflicts, even trivial ones.

> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi             |  2 +-
>  .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      |  2 +-
>  arch/arm64/boot/dts/broadcom/ns2-xmc.dts           | 24 +++++++++++-----------
>  arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |  2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  2 +-
>  arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts      |  2 +-
>  arch/arm64/boot/dts/marvell/berlin4ct-stb.dts      |  2 +-
>  arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |  2 +-
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  2 +-
>  arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts     |  2 +-
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  2 +-
>  arch/arm64/include/asm/assembler.h                 |  2 +-
>  arch/arm64/include/asm/boot.h                      |  4 ++--
>  arch/arm64/include/asm/elf.h                       |  2 +-
>  arch/arm64/include/asm/fixmap.h                    |  6 +++---
>  arch/arm64/kernel/head.S                           |  8 ++++----
>  arch/arm64/kernel/hyp-stub.S                       |  2 +-
>  arch/arm64/kernel/kaslr.c                          | 14 ++++++-------
>  arch/arm64/kernel/module-plts.c                    |  2 +-
>  arch/arm64/kernel/vmlinux.lds.S                    | 18 ++++++++--------
>  arch/arm64/mm/mmu.c                                |  2 +-
>  arch/arm64/mm/proc.S                               |  2 +-
>  22 files changed, 53 insertions(+), 53 deletions(-)

...
