From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 13 Jan 2015 15:11:21 +0300
Subject: [PATCH 1/2] ARM: dts: sun8i: Add lradc node to sun8i-a23.dtsi
In-Reply-To: <1421146024-17957-1-git-send-email-hdegoede@redhat.com>
References: <1421146024-17957-1-git-send-email-hdegoede@redhat.com>
Message-ID: <54B50B69.6000002@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/13/2015 1:47 PM, Hans de Goede wrote:

> The A23 has the same lradc controller as previous Allwinner SoCs.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   arch/arm/boot/dts/sun8i-a23.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)

> diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
> index a31842d..c2ceafb 100644
> --- a/arch/arm/boot/dts/sun8i-a23.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23.dtsi
> @@ -419,6 +419,13 @@
>   			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>
> +		lradc: lradc at 01c22800 {
> +			compatible = "allwinner,sun4i-a10-lradc-keys";

    If this is a keyboard controller, its node name should probably be 
"keyboard", according to the ePAPR standard...

WBR, Sergei
