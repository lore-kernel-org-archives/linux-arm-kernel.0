From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Apr 2014 16:45:03 +0200
Subject: [PATCH 02/15] ARM: sunxi: dt: document pinctrl clock related
 properties
In-Reply-To: <1397051478-4113-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397051478-4113-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140409144502.GD28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 03:51:05PM +0200, Boris BREZILLON wrote:
> Document clocks and clock-names properties for the pinctrl driver.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> index 0e7e9a1..b3e5c30 100644
> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> @@ -15,6 +15,10 @@ Required properties:
>    "allwinner,sun7i-a20-pinctrl"
>  - reg: Should contain the register physical address and length for the
>    pin controller.
> +- clocks: Should contain a list of gate clk needed by the pin controller
> +- clock-names: Should at least contain "pio_clk" which is used by the
> +  base pin controller. In case of sun6i-a31 SoC, this property should
> +  also contain the "pioL_clk" string.

You should probably mention that these two should be in the same
order.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140409/d424952f/attachment.sig>
