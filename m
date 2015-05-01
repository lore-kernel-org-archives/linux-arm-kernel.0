From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 May 2015 22:22:18 +0200
Subject: [PATCH 1/4] ARM: dts: sunxi: sun5i: add spi2_pins_b.
In-Reply-To: <bda468ecf45ca063098f756bdaba85b6f5f42263.1430295711.git.hramrach@gmail.com>
References: <cover.1430295711.git.hramrach@gmail.com>
 <bda468ecf45ca063098f756bdaba85b6f5f42263.1430295711.git.hramrach@gmail.com>
Message-ID: <20150501202218.GK6062@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 10:00:27AM +0200, Michal Suchanek wrote:
> spi2_pins_a are only available on A10s

spi2_pins_a doesn't mean anything without any context.

Anyone should be able to read this commit log alone and understand
what it's about and why you are doing it.

It's clearly not the case here.

> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>  arch/arm/boot/dts/sun5i.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> index 186d25f..9f22c28 100644
> --- a/arch/arm/boot/dts/sun5i.dtsi
> +++ b/arch/arm/boot/dts/sun5i.dtsi
> @@ -551,6 +551,13 @@
>  				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
>  				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>  			};
> +
> +			spi2_pins_b: spi2 at 1 {

You should probably name that group spi2_pins_a. It feels a bit weird
to have a spi2_pins_b group without its "a" counterpart.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150501/7496b708/attachment-0001.sig>
