From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Sep 2014 15:36:09 +0200
Subject: [PATCH v2 6/7] devicetree: bindings: Document supported
 Allwinner sunxi SoCs
In-Reply-To: <1411570141-29960-7-git-send-email-wens@csie.org>
References: <1411570141-29960-1-git-send-email-wens@csie.org>
 <1411570141-29960-7-git-send-email-wens@csie.org>
Message-ID: <20140925133609.GK15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 10:49:00PM +0800, Chen-Yu Tsai wrote:
> This adds a list of supported Allwinner SoC bindings.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunxi.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
> new file mode 100644
> index 0000000..d7d1039
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> @@ -0,0 +1,12 @@
> +Allwinner sunXi Platforms Device Tree Bindings
> +
> +Each device tree must specify which Allwinner SoC it uses,
> +using one of the following compatible stirngs:
                                         ^ strings

> +
> +  allwinner,sun4i-a10
> +  allwinner,sun5i-a10s
> +  allwinner,sun5i-a13
> +  allwinner,sun6i-a31
> +  allwinner,sun7i-a20
> +  allwinner,sun8i-a23
> +  allwinner,sun9i-a80

Maybe you can just add this info to the already existing README?


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/dc50cf99/attachment.sig>
