From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Apr 2014 16:43:48 +0200
Subject: [PATCH 01/15] ARM: sunxi: dt: list all pinctrl compatible strings
In-Reply-To: <1397051478-4113-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397051478-4113-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140409144348.GC28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 09, 2014 at 03:51:04PM +0200, Boris BREZILLON wrote:
> List all sunxi pinctrl compatible strings in order to be able to grep for
> those values.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt      | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> index dff0e5f..0e7e9a1 100644
> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> @@ -6,8 +6,13 @@ the first two functions being GPIO in and out. The configuration on
>  the pins includes drive strength and pull-up.
>  
>  Required properties:
> -- compatible: "allwinner,<soc>-pinctrl". Supported SoCs for now are:
> -  sun5i-a13.
> +- compatible: Should be one of the followings (depending on you SoC):
> +  "allwinner,sun4i-a10-pinctrl"
> +  "allwinner,sun5i-a10s-pinctrl"
> +  "allwinner,sun5i-a13-pinctrl"
> +  "allwinner,sun6i-a31-pinctrl"
> +  "allwinner,sun6i-a31-pinctrl"

Copy and paste error ? :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140409/c1892db8/attachment-0001.sig>
