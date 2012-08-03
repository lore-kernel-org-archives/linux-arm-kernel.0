From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 03 Aug 2012 21:22:19 +0400
Subject: [PATCH 1/4] arm/dts: omap5-evm: Add I2C support
In-Reply-To: <1343997486-710-2-git-send-email-sourav.poddar@ti.com>
References: <1343997486-710-1-git-send-email-sourav.poddar@ti.com>
 <1343997486-710-2-git-send-email-sourav.poddar@ti.com>
Message-ID: <501C08CB.3060701@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/03/2012 04:38 PM, Sourav Poddar wrote:

> Add I2C data node in omap5 device tree file.

> Tested on omap5430 sdp.

> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 57e5270..6b68dfe 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -145,6 +145,41 @@
>  			#interrupt-cells = <1>;
>  		};
>  
> +		i2c1: i2c at 48070000 {
> +			compatible = "ti,omap4-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "i2c1";

   Address postfix in the node name and no "reg" property?

WBR, Sergei
