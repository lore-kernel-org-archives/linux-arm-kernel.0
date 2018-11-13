From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Nov 2018 10:00:24 +0100
Subject: [PATCH] arm64: dts: allwinner: a64: Add mali node
In-Reply-To: <20181111121811.21638-1-jernej.skrabec@siol.net>
References: <20181111121811.21638-1-jernej.skrabec@siol.net>
Message-ID: <20181113090024.puzll77rx5dylnhf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

On Sun, Nov 11, 2018 at 01:18:11PM +0100, Jernej Skrabec wrote:
> A64 has Mali400 MP2 GPU. Add a node for it.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  This node and A64 GPU binary driver was tested with Kodi on LibreELEC.
> 
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index f3a66f888205..48cc5451d0eb 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -753,6 +753,28 @@
>  			#size-cells = <0>;
>  		};
>  
> +		mali: gpu at 1c40000 {
> +			compatible = "allwinner,sun50i-a64-mali",
> +				     "arm,mali-400";

You should document that new compatible string. The patch looks good
otherwise, thanks!

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181113/04db59d2/attachment.sig>
