From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Jan 2018 11:59:25 +0100
Subject: [linux-sunxi][PATCH 1/5] arm64: allwinner: a64: Add the SPDIF
 block
In-Reply-To: <20180124103943.2062-2-codekipper@gmail.com>
References: <20180124103943.2062-1-codekipper@gmail.com>
 <20180124103943.2062-2-codekipper@gmail.com>
Message-ID: <20180124105925.t4khedfybyuhhzqk@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 24, 2018 at 11:39:39AM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Add the SPDIF transceiver controller block to the A64 dtsi.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index d783d164b9c3..c82979038b0b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -382,6 +382,19 @@
>  			};
>  		};
>  
> +		spdif: spdif at 1c21000 {
> +			#sound-dai-cells = <0>;
> +			compatible = "allwinner,sun8i-h3-spdif";

Please add a SoC-specific compatible here, in addition the H3.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180124/4c2b7f9c/attachment.sig>
