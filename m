From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 22 Dec 2017 17:10:16 +0100
Subject: [PATCH 14/14] ARM: dts: at91: sama5d2: Add resistive touch device
In-Reply-To: <1513955241-10985-15-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
 <1513955241-10985-15-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20171222161016.GI18255@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22/12/2017 at 17:07:21 +0200, Eugen Hristev wrote:
> Add the resistive touchscreen device, and the cell numbers to the
> ADC device.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index b1a26b4..30b3797 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -402,7 +402,6 @@
>  					compatible = "atmel,hlcdc-display-controller";
>  					#address-cells = <1>;
>  					#size-cells = <0>;
> -

This is an unrelated change.

>  					port at 0 {
>  						#address-cells = <1>;
>  						#size-cells = <0>;

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
