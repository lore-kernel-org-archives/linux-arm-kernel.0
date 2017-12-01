From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 1 Dec 2017 18:11:32 -0200
Subject: [PATCH 2/8] ARM: dts: imx7: build imx7d-sbc-iot-imx7 dtb
In-Reply-To: <20171130201434.14122-3-tyler@opensourcefoundries.com>
References: <20171130201434.14122-1-tyler@opensourcefoundries.com>
 <20171130201434.14122-3-tyler@opensourcefoundries.com>
Message-ID: <CAOMZO5AKyYR+AYMpbOokKbkgAbaGAucHtdHrosPOh3wbEHY1sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 6:14 PM,  <tyler@opensourcefoundries.com> wrote:
> From: Tyler Baker <tyler@opensourcefoundries.com>
>
> Build the imx7d-sbc-iot-imx7 device tree blob.
>
> Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>
> ---
>  arch/arm/boot/dts/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d0381e9..0334137 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -515,6 +515,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
>         imx7d-nitrogen7.dtb \
>         imx7d-pico.dtb \
>         imx7d-sbc-imx7.dtb \
> +       imx7d-sbc-iot-imx7.dtb \

This could be part of the previous patch that introduces the dts.
