From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Dec 2017 08:46:19 +0100
Subject: [PATCH 2/5] media: dt: bindings: Update binding documentation
 for sunxi IR controller
In-Reply-To: <20171217224547.21481-3-embed3d@gmail.com>
References: <20171217224547.21481-1-embed3d@gmail.com>
 <20171217224547.21481-3-embed3d@gmail.com>
Message-ID: <20171218074619.36urdgt6wnhshadf@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Dec 17, 2017 at 11:45:44PM +0100, Philipp Rossak wrote:
> This patch updates documentation for Device-Tree bindings for sunxi IR
> controller and adds the new optional property for the base clock
> frequency.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/sunxi-ir.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/sunxi-ir.txt b/Documentation/devicetree/bindings/media/sunxi-ir.txt
> index 91648c569b1e..9f45bab07d6e 100644
> --- a/Documentation/devicetree/bindings/media/sunxi-ir.txt
> +++ b/Documentation/devicetree/bindings/media/sunxi-ir.txt
> @@ -11,6 +11,7 @@ Required properties:
>  Optional properties:
>  - linux,rc-map-name: see rc.txt file in the same directory.
>  - resets : phandle + reset specifier pair
> +- clock-frequency  : overrides the default base clock frequency (8 MHz)

You're at least missing the unit one needs to use, but something like:
IR Receiver clock frequency, in Hertz. Defaults to 8MHz if missing.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171218/b30f0dbc/attachment.sig>
