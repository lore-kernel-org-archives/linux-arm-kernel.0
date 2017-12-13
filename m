From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Dec 2017 16:57:42 +0100
Subject: [PATCH v4 3/4] ARM: dts: add pwm node for r40.
In-Reply-To: <20171213144628.GA18246@arx-s1>
References: <20171213144628.GA18246@arx-s1>
Message-ID: <20171213155742.he2wmdf6camsua5k@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 13, 2017 at 10:46:28PM +0800, hao_zhang wrote:
> This patch add pwm node for r40.
> 
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts |  6 ++++++
>  arch/arm/boot/dts/sun8i-r40.dtsi                  | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> index 8c5efe2..6cf6273 100644
> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> @@ -196,6 +196,12 @@
>  	status = "okay";
>  };
>  
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_pins>;
> +	status = "okay";
> +};
> +

Can you split this part into a separate patch?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171213/c23a1b7b/attachment.sig>
