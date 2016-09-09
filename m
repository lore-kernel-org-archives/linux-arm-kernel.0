From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Sep 2016 09:06:59 +0200
Subject: [PATCH 4/4] ARM: dts: add RealView EB rev D A9 MPCore variant
In-Reply-To: <1473371209-24086-4-git-send-email-linus.walleij@linaro.org>
References: <1473371209-24086-1-git-send-email-linus.walleij@linaro.org>
 <1473371209-24086-4-git-send-email-linus.walleij@linaro.org>
Message-ID: <6789480.EASISD7LWe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 11:46:49 PM CEST Linus Walleij wrote:
> The Cortex A9 MPCore tile can be mounted on top of the revision
> D variant of the RealView EB, so create another variant of the
> DTS file for this.
> 
> arm-realview-eb-a9mp = mounted on pre-revision D baseboard
> arm-realview-eb-a9mp-bbrevd = mounted on the revision D baseboard
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile                        |  1 +
>  arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dts | 28 +++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 2ec6f6236165..0f911bdc4282 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -614,6 +614,7 @@ dtb-$(CONFIG_ARCH_REALVIEW) += \
>         arm-realview-eb-11mp-ctrevb.dtb \
>         arm-realview-eb-11mp-bbrevd-ctrevb.dtb \
>         arm-realview-eb-a9mp.dtb \
> +       arm-realview-eb-a9mp-bbrevd.dtb \
>         arm-realview-pba8.dtb \
>         arm-realview-pbx-a9.dtb

All four patches look good to me. I wish we could come up with
a better naming scheme, but your approach is better than anything
I could think of already.

	Arnd
