From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 16 Apr 2014 17:11:12 +0800
Subject: [PATCH v2 0/2] ARM: berlin: add GPIO support for the BG2Q
In-Reply-To: <1397634395-7456-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1397634395-7456-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140416171112.31757110@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Apr 2014 00:46:33 -0700
Antoine T?nart <antoine.tenart@free-electrons.com> wrote:

> This series add the support for the GPIOs of the Berlin BG2Q. We use the
> newly integrated dwapb GPIO driver here.
> 
> This applies on top of Alexandre's BG2Q symbol introduction[1] and the dwapb
> gpio patch fixing IRQ initialization[2].
> 
> [1] https://patchwork.kernel.org/patch/3876141/
> [2] https://lkml.org/lkml/2014/4/7/96
> 
> Changes since v1:
> 	- s/gpio-controller@/gpio-port@/ in device tree
> 	- moved ARCH_REQUIRE_GPIOLIB to ARCH_BERLIN in Kconfig
> 
> Antoine T?nart (2):
>   ARM: berlin: add the LIBGPIO as a dependency for the BG2Q
>   ARM: dts: berlin: add GPIO nodes for the BG2Q
> 
>  arch/arm/boot/dts/berlin2q.dtsi | 102
> ++++++++++++++++++++++++++++++++++++++++ arch/arm/mach-berlin/Kconfig
> |   1 + 2 files changed, 103 insertions(+)
> 

All the two patches look good

Thanks very much
