From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 Apr 2014 14:11:39 +0800
Subject: [PATCH 02/10] ARM: dts: Add Phytec pbab01 with i.MX6 DualLite/Solo
In-Reply-To: <1397489852-1669-2-git-send-email-p.zabel@pengutronix.de>
References: <1397489852-1669-1-git-send-email-p.zabel@pengutronix.de>
 <1397489852-1669-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140416061138.GD2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 05:37:24PM +0200, Philipp Zabel wrote:
> The PBA-B-01 carrier board can be equipped with either Quad or DualLite/Solo
> phyFLEX i.MX6 modules (PFL-A-02).
> This moves all common devices into imx6qdl-phytec-pbab01.dtsi. The SoC specific
> device trees then just include the pfla01 and pbab01 dtsi files corresponding
> to the SoC variant.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  arch/arm/boot/dts/Makefile                   |  1 +
>  arch/arm/boot/dts/imx6dl-phytec-pbab01.dts   | 19 ++++++++++++++
>  arch/arm/boot/dts/imx6q-phytec-pbab01.dts    | 31 ++---------------------
>  arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi | 38 ++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 29 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6dl-phytec-pbab01.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 35c146f..1afa764 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -197,6 +197,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx6q-gw54xx.dtb \
>  	imx6q-nitrogen6x.dtb \
>  	imx6q-phytec-pbab01.dtb \
> +	imx6dl-phytec-pbab01.dtb \

Forgot mentioning that it should be put alphabetically in there.  I
fixed it up when applying.

Shawn

>  	imx6q-sabreauto.dtb \
>  	imx6q-sabrelite.dtb \
>  	imx6q-sabresd.dtb \
