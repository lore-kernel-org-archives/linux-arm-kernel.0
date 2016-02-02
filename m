From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 2 Feb 2016 17:28:33 +0100
Subject: [PATCH 2/2] dt-bindings: Add TPO TPG110 binding
In-Reply-To: <1454316643-3931-1-git-send-email-linus.walleij@linaro.org>
References: <1454316643-3931-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160202162833.GB4918@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 09:50:43AM +0100, Linus Walleij wrote:
> This adds device tree bindings for the TPO TPG110 panel found
> mounted in the Nomadik NHK8815.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/display/panel/tpo,tpg110.txt          | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt b/Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt
> new file mode 100644
> index 000000000000..acbc6bef3593
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt
> @@ -0,0 +1,47 @@
> +TPO TPG110 Panel
> +================
> +
> +This binding builds on the DPI bindings, adding a few properties
> +as a superset of a DPI. See panel-dpi.txt for the required DPI
> +bindings.

It is unfortunate that we have these two types of bindings, one used by
some of the legacy fbdev drivers and the other by DRM/KMS drivers. There
isn't really much we can do about it, though, as far as I can see.

This panel is used with an fbdev driver, right?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/6af19370/attachment.sig>
