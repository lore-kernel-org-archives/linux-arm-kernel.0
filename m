From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Dec 2017 15:23:42 +0100
Subject: [PATCH v2 3/6] arm: dts: sun8i: a83t: Add the cir pin for the A83T
In-Reply-To: <20171218141146.23746-4-embed3d@gmail.com>
References: <20171218141146.23746-1-embed3d@gmail.com>
 <20171218141146.23746-4-embed3d@gmail.com>
Message-ID: <20171218142342.l4ucukeqjirtgetk@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 03:11:43PM +0100, Philipp Rossak wrote:
> The CIR Pin of the A83T is located at PL12.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index de5119a2a91c..feffca8a9a24 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -623,6 +623,11 @@
>  				drive-strength = <20>;
>  				bias-pull-up;
>  			};
> +
> +			cir_pins: cir-pins at 0 {
> +				pins = "PL12";
> +				function = "s_cir_rx";
> +			};

Sorry for not noticing this earlier, but the nodes should be ordered
alphabetically.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171218/63bf0073/attachment.sig>
