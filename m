From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jan 2018 09:39:27 +0100
Subject: [PATCH v4 4/6] arm: dts: sun8i: a83t: Add support for the cir
 interface
In-Reply-To: <20180129155810.7867-5-embed3d@gmail.com>
References: <20180129155810.7867-1-embed3d@gmail.com>
 <20180129155810.7867-5-embed3d@gmail.com>
Message-ID: <20180130083927.z4jcilqm3aludncb@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Mon, Jan 29, 2018 at 04:58:08PM +0100, Philipp Rossak wrote:
> The cir interface is like on the H3 located at 0x01f02000 and is exactly
> the same. This patch adds support for the ir interface on the A83T.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 06e96db7c41a..ddc0d592107f 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -605,6 +605,16 @@
>  			#reset-cells = <1>;
>  		};
>  
> +		cir: cir at 01f02000 {

r_cir: ir at 1f02000

> +			compatible = "allwinner,sun5i-a13-ir";

You should have an A83t compatible there first.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180130/eb2039d4/attachment.sig>
