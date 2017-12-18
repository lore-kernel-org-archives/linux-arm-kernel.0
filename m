From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Dec 2017 15:22:41 +0100
Subject: [PATCH v2 2/6] media: dt: bindings: Update binding documentation
 for sunxi IR controller
In-Reply-To: <20171218141146.23746-3-embed3d@gmail.com>
References: <20171218141146.23746-1-embed3d@gmail.com>
 <20171218141146.23746-3-embed3d@gmail.com>
Message-ID: <20171218142241.6hhuyr74pxtvpoyp@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 03:11:42PM +0100, Philipp Rossak wrote:
> This patch updates documentation for Device-Tree bindings for sunxi IR
> controller and adds the new optional property for the base clock
> frequency.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/sunxi-ir.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/sunxi-ir.txt b/Documentation/devicetree/bindings/media/sunxi-ir.txt
> index 91648c569b1e..3d7f18780fae 100644
> --- a/Documentation/devicetree/bindings/media/sunxi-ir.txt
> +++ b/Documentation/devicetree/bindings/media/sunxi-ir.txt
> @@ -11,6 +11,8 @@ Required properties:
>  Optional properties:
>  - linux,rc-map-name: see rc.txt file in the same directory.
>  - resets : phandle + reset specifier pair
> +- clock-frequency  : IR Receiver clock frequency, in Herz. Defaults to 8 MHz
                                                        ^ Hertz

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171218/811338e0/attachment.sig>
