From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Jan 2018 12:01:24 +0100
Subject: [linux-sunxi][PATCH 3/5] arm64: allwinner: a64: Add SPDIF to the
 A64
In-Reply-To: <20180124103943.2062-4-codekipper@gmail.com>
References: <20180124103943.2062-1-codekipper@gmail.com>
 <20180124103943.2062-4-codekipper@gmail.com>
Message-ID: <20180124110124.pgvk7bwesftgbjtj@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 11:39:41AM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Add the device tree sound bindings for the S/PDIF block.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index db1694ec3ee4..f060a58f374c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -112,6 +112,25 @@
>  		method = "smc";
>  	};
>  
> +
> +	sound_spdif {

Nit: You should drop the extra blank line here.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180124/edd4a981/attachment.sig>
