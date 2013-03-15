From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 16 Mar 2013 01:01:32 +0300
Subject: [PATCH 4/6] ARM: sunxi: dt: Add uart3 dt node
In-Reply-To: <1363377988-4966-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1363377988-4966-1-git-send-email-maxime.ripard@free-electrons.com>
 <1363377988-4966-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <51439A3C.1010505@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/15/2013 11:06 PM, Maxime Ripard wrote:

> Both A10 and A13 Allwinner SoCs have a Synopsys APB uart3 device
> available, so add it to the sunxi.dtsi file
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>   arch/arm/boot/dts/sunxi.dtsi |   10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
> index 4f78ef7..324da45 100644
> --- a/arch/arm/boot/dts/sunxi.dtsi
> +++ b/arch/arm/boot/dts/sunxi.dtsi
> @@ -68,5 +68,15 @@
>   			clocks = <&osc>;
>   			status = "disabled";
>   		};
> +
> +		uart3: uart at 01c28c00 {

    IIRC, historically, the property name should be "serial", not "uart".

WBR, Sergei
