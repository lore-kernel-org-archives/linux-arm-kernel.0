From: cphealy@gmail.com (Chris Healy)
Date: Tue, 17 Jul 2018 08:08:55 -0700
Subject: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
In-Reply-To: <20180717040651.641-1-andrew.smirnov@gmail.com>
References: <20180717040651.641-1-andrew.smirnov@gmail.com>
Message-ID: <CAFXsbZpdJvB3OtEnjjx5rNvgutmhFs=VK3uimRJnvQHLwzwYSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 9:06 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Add support for Zodiac Inflight Innovations SSMB SPU3
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
>  arch/arm/boot/dts/Makefile                |   3 +-
>  arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 343 ++++++++++++++++++++++
>  2 files changed, 345 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index bea41b129493..e331b2c16539 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -570,7 +570,8 @@ dtb-$(CONFIG_SOC_VF610) += \
>         vf610m4-cosmic.dtb \
>         vf610-twr.dtb \
>         vf610-zii-dev-rev-b.dtb \
> -       vf610-zii-dev-rev-c.dtb
> +       vf610-zii-dev-rev-c.dtb \
> +       vf610-zii-ssmb-spu3.dtb


Tested-by: Chris Healy <cphealy@gmail.com>
