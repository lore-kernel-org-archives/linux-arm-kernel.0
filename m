From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 5 Jun 2016 10:58:04 -0300
Subject: [PATCH RFT 3/4] ARM: dts: imx28-cfa10049: fix dtc warning
In-Reply-To: <1465134715-13497-1-git-send-email-stefan.wahren@i2se.com>
References: <1465134715-13497-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CAOMZO5AY57Q1mdiUFZpMnJ2Dd4xFTB7EBWs8BYW+kfJMRu-r6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Sun, Jun 5, 2016 at 10:51 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

> diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
> index ef944b6..a9c347e 100644
> --- a/arch/arm/boot/dts/imx28-cfa10049.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10049.dts
> @@ -426,7 +426,7 @@
>
>         };
>
> -       onewire at 0 {
> +       onewire {

As a separate patch, it would be nice to fix
Documentation/devicetree/bindings/w1/w1-gpio.txt as well.
