From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 23 Jan 2017 18:10:10 +0100
Subject: [PATCH v2 6/9] ARM: dts: add support for I2SE Duckbill 2 485
In-Reply-To: <1485123764-14754-7-git-send-email-mhei@heimpold.de>
References: <1485123764-14754-1-git-send-email-mhei@heimpold.de>
 <1485123764-14754-7-git-send-email-mhei@heimpold.de>
Message-ID: <ff21bcf8-7699-025f-5129-e1906914ce42@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.01.2017 um 23:22 schrieb Michael Heimpold:
> This machine is based on I2SE's Duckbill 2 board and features a
> RS-485 daugther board. This device is intended to be used for
> e.g. home automation purposes.
>
> Signed-off-by: Michael Heimpold <mhei@heimpold.de>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/Makefile                 |   1 +
>  arch/arm/boot/dts/imx28-duckbill-2-485.dts | 189 +++++++++++++++++++++++++++++
>  2 files changed, 190 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-485.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index fa4664b..e0f3f4e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -475,6 +475,7 @@ dtb-$(CONFIG_ARCH_MXS) += \
>  	imx28-cfa10056.dtb \
>  	imx28-cfa10057.dtb \
>  	imx28-cfa10058.dtb \
> +	imx28-duckbill-2-485.dts \

The file ending should be dtb. This issue applies also to patch 7 and 8.
