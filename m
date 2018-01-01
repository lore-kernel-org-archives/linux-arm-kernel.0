From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 1 Jan 2018 19:50:57 -0200
Subject: [PATCH v2] ARM: dts: imx6: RDU2: disable internal watchdog
In-Reply-To: <20180101212451.11516-1-andrew.smirnov@gmail.com>
References: <20180101212451.11516-1-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5AZU0LOcz6s2w-mThJfJeO0_mXga_1Cc2-aBkMOXk_-dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Mon, Jan 1, 2018 at 7:24 PM, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 6bef9a98678e..818bfc8692a5 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -838,6 +838,10 @@
>         status = "okay";
>  };
>
> +&wdog1 {
> +       status = "disabled";
> +};
> +
>  &audmux {

We should keep the nodes in alphabetical order. Other than that:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
