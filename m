From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 7 Oct 2016 20:11:44 +0300
Subject: [PATCH/RFT 11/12] ARM: dts: da850: Add the usb ohci device node
In-Reply-To: <1475858577-10366-12-git-send-email-ahaslam@baylibre.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
 <1475858577-10366-12-git-send-email-ahaslam@baylibre.com>
Message-ID: <7227c5ff-4f9e-bcb5-ea0f-cdd122d42445@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/07/2016 07:42 PM, ahaslam at baylibre.com wrote:

> From: Axel Haslam <ahaslam@baylibre.com>
>
> This adds the device tree node for the usb11 (ohci)
> controller present in the da850 family of SoC's.
>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 33fcdce..afae565 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -381,6 +381,14 @@
>  			#phy-cells = <1>;
>  			status = "disabled";
>  		};
> +		usb11: usb11 at 0225000 {

    No, usb@<unit-address> to comply with the DT spec the node names should be 
generic.

[...]

MBR, Sergei
