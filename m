From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Jan 2018 10:49:18 +0100
Subject: [PATCH v2 11/16] arm: dts: sunxi-h3-h5: add support for the
 thermal sensor in H3 and H5
In-Reply-To: <20180128232919.12639-12-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-12-embed3d@gmail.com>
Message-ID: <20180129094918.4fvxpmoftgxxkqg3@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 29, 2018 at 12:29:14AM +0100, Philipp Rossak wrote:
> As we have gained the support for the thermal sensor in H3 and H5,
> we can now add its device nodes to the device tree. The H3 and H5 share
> most of its compatible. The compatible and the thermal sensor cells
> will be added in an additional patch per device.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 7a83b15225c7..413c789b588d 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -426,6 +426,15 @@
>  			};
>  		};
>  
> +		ths: thermal-sensor at 1c25000 {
> +			reg = <0x01c25000 0x100>;

The size is 0x400

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/9b31e573/attachment.sig>
