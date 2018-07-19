From: cphealy@gmail.com (Chris Healy)
Date: Wed, 18 Jul 2018 20:43:23 -0700
Subject: [PATCH] ARM: dts: vf610: Add ZII CFU1 board
In-Reply-To: <20180719005941.10458-1-andrew.smirnov@gmail.com>
References: <20180719005941.10458-1-andrew.smirnov@gmail.com>
Message-ID: <CAFXsbZrb6_EmkMEhCT064LgjdWPq4t7hBYGg_UM9WLXW2WbZaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Add support for the Zodiac Inflight Innovations CFU1
> board (VF610-based).
>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: cphealy at gmail.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> Shawn:
>
> Currently this patch is rebase on top of [spu3], if that is
> problematic, let me know and I'll update it accordingly
>
> Thanks,
> Andrey Smirnov
>
> [spu3] lkml.kernel.org/r/20180717040651.641-1-andrew.smirnov at gmail.com
>
>  arch/arm/boot/dts/Makefile           |   1 +
>  arch/arm/boot/dts/vf610-zii-cfu1.dts | 307 +++++++++++++++++++++++++++
>  2 files changed, 308 insertions(+)
>  create mode 100644 arch/arm/boot/dts/vf610-zii-cfu1.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e331b2c16539..85797819fdd9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -569,6 +569,7 @@ dtb-$(CONFIG_SOC_VF610) += \
>         vf610-cosmic.dtb \
>         vf610m4-cosmic.dtb \
>         vf610-twr.dtb \
> +       vf610-zii-cfu1.dtb \
>         vf610-zii-dev-rev-b.dtb \


Tested-by: Chris Healy <cphealy@gmail.com>
