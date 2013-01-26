From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 26 Jan 2013 23:49:07 +0400
Subject: [PATCH v2 5/6] ARM: dts: omap5: add dwc3 core dt data
In-Reply-To: <1359112312-6918-6-git-send-email-kishon@ti.com>
References: <1359112312-6918-1-git-send-email-kishon@ti.com>
 <1359112312-6918-6-git-send-email-kishon@ti.com>
Message-ID: <51043333.6030208@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-01-2013 15:11, Kishon Vijay Abraham I wrote:

> Add dwc3 core dt data as a subnode to dwc3 omap glue data in omap5 dt
> data file. The information for the entered data node is available @
> Documentation/devicetree/bindings/usb/dwc3.txt

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/omap5.dtsi |    7 +++++++
>   1 file changed, 7 insertions(+)

> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 1703a72..58118c4 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -522,6 +522,13 @@
>   			#size-cells = <1>;
>   			utmi-mode = <2>;
>   			ranges;
> +			dwc3 at 4a030000 {
> +				compatible = "synopsys,dwc3";
> +				reg = <0x4a030000 0xcfff>;

    Same question here.

WBR, Sergei
