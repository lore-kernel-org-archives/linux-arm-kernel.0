From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 16 May 2013 14:25:08 -0300
Subject: [PATCH 2/2] ARM: dts: imx28: Adjust i2c interrupt bindings
In-Reply-To: <CAOMZO5AWBi4gDJCOJf5muFuRXygQAysYCHEL+gb_LwsXiy-knA@mail.gmail.com>
References: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
 <1368713639-21485-2-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5AWBi4gDJCOJf5muFuRXygQAysYCHEL+gb_LwsXiy-knA@mail.gmail.com>
Message-ID: <CAOMZO5AKKVeTMsXpG9wa-eeLocBStUwPjQEe3n6fRVY2aSc7Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 12:50 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Actually the correct is:
>
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -878,7 +878,7 @@
>                                 #size-cells = <0>;
>                                 compatible = "fsl,imx28-i2c";
>                                 reg = <0x80058000 0x2000>;
> -                               interrupts = <111 68>;
> +                               interrupts = <68>;
>                                 clock-frequency = <100000>;
>                                 dmas = <&dma_apbx 6>;
>                                 dma-names = "rx-tx";
> @@ -891,7 +891,7 @@
>                                 #size-cells = <0>;
>                                 compatible = "fsl,imx28-i2c";
>                                 reg = <0x8005a000 0x2000>;
> -                               interrupts = <110 69>;
> +                               interrupts = <69>;
>                                 clock-frequency = <100000>;
>                                 dmas = <&dma_apbx 7>;
>                                 dma-names = "rx-tx";

Sorry, the original patch is correct.

i2c slowness is a different issue.
