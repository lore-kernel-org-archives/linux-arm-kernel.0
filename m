From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 17 Feb 2016 11:11:18 +0200
Subject: [PATCH 07/11] Documentation/DT: add Versatile display bindings
In-Reply-To: <1454594660-7532-8-git-send-email-linus.walleij@linaro.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-8-git-send-email-linus.walleij@linaro.org>
Message-ID: <56C43936.2060808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/02/16 16:04, Linus Walleij wrote:
> This adds bindings for the LCD displays that can be found connected
> to the ARM Versatile reference design, interface boards IB1 and
> IB2.
> 
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/display/panel/epson,l2f50113t00.txt        | 7 +++++++
>  .../devicetree/bindings/display/panel/sanyo,alr252rgt.txt          | 7 +++++++
>  .../devicetree/bindings/display/panel/sanyo,tm38qv67a02a.txt       | 7 +++++++
>  .../devicetree/bindings/display/panel/sharp,lq084v1dg21.txt        | 7 +++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt              | 1 +
>  5 files changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/epson,l2f50113t00.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sanyo,alr252rgt.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sanyo,tm38qv67a02a.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq084v1dg21.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/epson,l2f50113t00.txt b/Documentation/devicetree/bindings/display/panel/epson,l2f50113t00.txt
> new file mode 100644
> index 000000000000..58eca804dbe8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/epson,l2f50113t00.txt
> @@ -0,0 +1,7 @@
> +Epson Mobile display
> +
> +Required properties:
> +- compatible: should be "epson,l2f50113t00"
> +
> +This binding is compatible with the panel-dpi binding, which is specified
> +in panel-dpi.txt in this directory.

Do we really want to add new binding doc files for all panels, even if
they just point to a more generic binding? We may end up with quite a
lot of these, each only saying "look at the panel-dpi.txt".

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/39cfbc9c/attachment-0001.sig>
