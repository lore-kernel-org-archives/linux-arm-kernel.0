From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Apr 2017 09:09:29 +0200
Subject: [PATCH] arm64: allwinner: h5: add support for Orange Pi Prime
 board
In-Reply-To: <20170407165630.7632-1-icenowy@aosc.io>
References: <20170407165630.7632-1-icenowy@aosc.io>
Message-ID: <20170410070929.2qdg7h6d5salmvpw@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 08, 2017 at 12:56:30AM +0800, Icenowy Zheng wrote:
> Orange Pi Prime is a new Allwinner H5-based SBC by Xunlong.
> 
> It's like a Orange Pi Plus 2E with H3 replaced with H5, eMMC replaced
> with onboard SPI NOR Flash and wireless card changed to Realtek
> RTL8723BS (with Bluetooth functionality).
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>  .../dts/allwinner/sun50i-h5-orangepi-prime.dts     | 202 +++++++++++++++++++++
>  2 files changed, 203 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index 244e8b7565f9..92a84eea6b96 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -1,6 +1,7 @@
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
>  
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
> new file mode 100644
> index 000000000000..2ebfe6c359ed
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
> @@ -0,0 +1,202 @@
> +/*
> + * Copyright (C) 2016 ARM Ltd.

You're sure?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170410/20f1a7b1/attachment.sig>
