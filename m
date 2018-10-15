From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Oct 2018 11:03:33 -0300
Subject: [PATCH v2 3/4] ARM: dts: imx6ull: Add dcp node
In-Reply-To: <9365e24504896e58294fd8786acb3c3d4a1a264d.1539609921.git.leonard.crestez@nxp.com>
References: <cover.1539609921.git.leonard.crestez@nxp.com>
 <9365e24504896e58294fd8786acb3c3d4a1a264d.1539609921.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5AMwGakygMT=O9CjN8jyL-FAox3-452C1vpGc9sPCXBHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 10:28 AM Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
> index 796ed35d4ac9..be610339e933 100644
> --- a/arch/arm/boot/dts/imx6ull.dtsi
> +++ b/arch/arm/boot/dts/imx6ull.dtsi
> @@ -37,10 +37,20 @@
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         reg = <0x02200000 0x100000>;
>                         ranges;
>
> +                       dcp: dcp at 2280000 {

Node names should be generic, so it would be better to use:

dcp: crypto at 2280000 {
