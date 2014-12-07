From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 7 Dec 2014 16:01:32 +0100
Subject: [PATCH 07/10] ARM: dts: sun9i: Add pinmux setting for mmc0
In-Reply-To: <1417588565-26215-8-git-send-email-wens@csie.org>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
 <1417588565-26215-8-git-send-email-wens@csie.org>
Message-ID: <20141207150132.GF12434@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 03, 2014 at 02:36:02PM +0800, Chen-Yu Tsai wrote:
> mmc0 is only available on port F, and is always used with a 4 bit wide
> bus for the onboard micro-sd slot.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  arch/arm/boot/dts/sun9i-a80.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> index c766698..f5b5645 100644
> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> @@ -458,6 +458,14 @@
>  				allwinner,pull = <0>;
>  			};
>  
> +			mmc0_pins: mmc0 {
> +				allwinner,pins = "PF0","PF1","PF2","PF3",
> +						 "PF4","PF5";

A space after each comma please.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141207/c5769288/attachment.sig>
