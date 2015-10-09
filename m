From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Oct 2015 09:12:01 -0500
Subject: [PATCH v2] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <5612A473.8030405@sigmadesigns.com>
References: <560EAA7C.3070302@free.fr> <5124277.UR9sg1IOHT@wuerfel>
 <560EFDB3.9010305@free.fr> <11113740.WL812ZaRcZ@wuerfel>
 <5612A473.8030405@sigmadesigns.com>
Message-ID: <CAL_Jsq+kgAF_2QJXjcc0Vy3kn4r5s1ZQiX40x77ohpJj7KhCOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 5, 2015 at 11:25 AM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:
> This patch adds support for Sigma Designs "Tango4" platform, which is
> built around the ARM Cortex A9 MPCore (single and dual core SoCs).

> --- /dev/null
> +++ b/arch/arm/boot/dts/tango4-vantage-1172.dts
> @@ -0,0 +1,17 @@
> +/dts-v1/;
> +
> +#include "tango4.dtsi"
> +
> +/ {
> +       model = "Sigma Designs SMP8758 Vantage-1172 dev board";
> +       compatible = "sigma,vantage-1172", "sigma,smp8758", "sigma,tango4";

Also, these compatible strings need to be documented.

Rob
