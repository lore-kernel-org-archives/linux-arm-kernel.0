From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 15 May 2018 08:44:53 -0300
Subject: [PATCH] ARM: dts: imx7d: correct cpu supply name for voltage
 scaling
In-Reply-To: <1526375609-17676-1-git-send-email-Anson.Huang@nxp.com>
References: <1526375609-17676-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5Ci6Kmb9hK7=pvYXURWLfRun1gu+XOskXAe0xo=v1NTpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 6:13 AM, Anson Huang <Anson.Huang@nxp.com> wrote:

> diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> index 7f64568..60deaf9 100644
> --- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> +++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> @@ -33,7 +33,7 @@
>  };
>
>  &cpu0 {
> -       arm-supply = <&sw1a_reg>;
> +       cpu-supply = <&sw1a_reg>;
>  };
>
>  &fec1 {
> @@ -284,4 +284,4 @@
>                         MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5     0x14 /* OTG PWREN */
>                 >;
>         };
> -};
> \ No newline at end of file
> +};

This change seems unrelated.

Other than that:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
