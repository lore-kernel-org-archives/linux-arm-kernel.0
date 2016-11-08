From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Nov 2016 19:47:15 +0100
Subject: [PATCH v3 2/3] ARM64: dts: sun6i: add dma node for a64.
In-Reply-To: <20161107182247.GA3669@arx12>
References: <20161107182247.GA3669@arx12>
Message-ID: <20161108184715.x5kjhjthmuxor2xz@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 08, 2016 at 02:22:47AM +0800, Hao Zhang wrote:
> This adds the dma node for sun50i a64.
> 
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index e3c3d7d8..855ae2c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -227,6 +227,15 @@
>  			};
>  		};
>  
> +		dma: dma-controller at 01c02000 {

Please order the nodes by base adress, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/cd8a7e91/attachment.sig>
