From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 11 Mar 2013 22:19:46 -0700 (PDT)
Subject: [PATCH 00/04] ARM: shmobile: r8a73a4 SoC and APE6EVM board support
In-Reply-To: <20130312045559.19701.77841.sendpatchset@w520>
References: <20130312045559.19701.77841.sendpatchset@w520>
Message-ID: <87vc8xry8i.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

> ARM: shmobile: r8a73a4 SoC and APE6EVM board support
> 
> [PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support
> [PATCH 02/04] ARM: shmobile: r8a73a4 SCIF support
> [PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support
> [PATCH 04/04] ARM: shmobile: APE6EVM support
> 
> This series adds initial support for r8a73a4 and APE6EVM. The SoC
> is known as r8a73a4 which is built around Cortex-A15 and makes use
> of SCIF for serial and IRQC interrupt controller for external IRQs.
> 
> This initial SoC and board support is providing limited DT-only
> support and a very basic C-version of board support. In the future
> improved PINCTRL and clock framework support will be added, followed
> by SMP support.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against all+next in renesas.git.
>  [PATCH 03/04] requires the IRQC driver to build
> 
>  arch/arm/boot/dts/Makefile                    |    1 
>  arch/arm/boot/dts/r8a73a4-ape6evm.dts         |   26 ++
>  arch/arm/boot/dts/r8a73a4.dtsi                |   87 ++++++++
>  arch/arm/mach-shmobile/Kconfig                |   16 +
>  arch/arm/mach-shmobile/Makefile               |    2 
>  arch/arm/mach-shmobile/board-ape6evm.c        |   40 +++
>  arch/arm/mach-shmobile/clock-r8a73a4.c        |  104 +++++++++
>  arch/arm/mach-shmobile/include/mach/r8a73a4.h |    7 
>  arch/arm/mach-shmobile/setup-r8a73a4.c        |  268 +++++++++++++++++++++++++
>  9 files changed, 549 insertions(+), 2 deletions(-)

For all patches

Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
