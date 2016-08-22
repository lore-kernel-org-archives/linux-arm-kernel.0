From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Aug 2016 09:58:47 +0200
Subject: [PATCH v3 1/2] Documentation: dt: Add new compatible to sunxi
 mmc driver bindings
In-Reply-To: <20160801151351.51854-2-icenowy@aosc.xyz>
References: <20160801151351.51854-1-icenowy@aosc.xyz>
 <20160801151351.51854-2-icenowy@aosc.xyz>
Message-ID: <20160822075847.GD7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

On Mon, Aug 01, 2016 at 11:13:50PM +0800, Icenowy Zheng wrote:
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v2:
> - Rebased on Hans de Goede's patchset.
> 
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> index 904ff9f..55cdd80 100644
> --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> @@ -13,6 +13,7 @@ Required properties:
>     * "allwinner,sun5i-a13-mmc"
>     * "allwinner,sun7i-a20-mmc"
>     * "allwinner,sun9i-a80-mmc"
> +   * "allwinner,sun50i-a64-mmc"
>   - reg : mmc controller base registers
>   - clocks : a list with 4 phandle + clock specifier pairs
>   - clock-names : must contain "ahb", "mmc", "output" and "sample"

You need to document that the output and sample clocks are not
mandatory in the A64 case.

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/4158e8a6/attachment.sig>
