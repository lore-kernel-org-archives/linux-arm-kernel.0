From: eric@anholt.net (Eric Anholt)
Date: Thu, 02 Feb 2017 10:05:53 -0800
Subject: [PATCH V2] Add devicetree for the Raspberry Pi 3, for arm (32)
In-Reply-To: <20170202090536.16724-1-mzoran@crowfest.net>
References: <20170202090536.16724-1-mzoran@crowfest.net>
Message-ID: <871svgxybi.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Zoran <mzoran@crowfest.net> writes:

> Signed-off-by: Michael Zoran <mzoran@crowfest.net>
> ---
>  arch/arm/boot/dts/Makefile            | 3 ++-
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 8bd8878efe7b..72ba524df912 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -72,7 +72,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
>  	bcm2835-rpi-b-plus.dtb \
>  	bcm2835-rpi-a-plus.dtb \
>  	bcm2836-rpi-2-b.dtb \
> -	bcm2835-rpi-zero.dtb
> +	bcm2835-rpi-zero.dtb \
> +	bcm2837-rpi-3-b.dtb
>  dtb-$(CONFIG_ARCH_BCM_5301X) += \
>  	bcm4708-asus-rt-ac56u.dtb \
>  	bcm4708-asus-rt-ac68u.dtb \
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> new file mode 100644
> index 000000000000..48ad20f83255
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> @@ -0,0 +1,2 @@
> +#include "../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts"
> +

This won't work, for the same reason as v1.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170202/859df803/attachment-0001.sig>
