From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Nov 2015 13:38:37 +0100
Subject: [PATCH v2 4/5] dt-bindings: document sun8i_ths
In-Reply-To: <20e229f191031b0b0bff96dee118d1f2d988d7b3.1448263428.git.atx@atx.name>
References: <cover.1448263428.git.atx@atx.name>
 <20e229f191031b0b0bff96dee118d1f2d988d7b3.1448263428.git.atx@atx.name>
Message-ID: <20151123123837.GV32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 23, 2015 at 09:02:51AM +0100, Josef Gajdusek wrote:
> This patch adds the binding documentation for the sun8i_ths driver
> 
> Signed-off-by: Josef Gajdusek <atx@atx.name>
> ---
>  .../devicetree/bindings/thermal/sun8i-ths.txt      | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-ths.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/sun8i-ths.txt b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
> new file mode 100644
> index 0000000..67056bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
> @@ -0,0 +1,31 @@
> +* sun8i THS
> +
> +Required properties:
> +- compatible : "allwinner,sun8i-h3-ths"
> +- reg : Address range of the thermal registers and location of the calibration
> +        value
> +- resets : Must contain an entry for each entry in reset-names.
> +           see ../reset/reset.txt for details
> +- reset-names : Must include the name "ahb"

If you have a single reset line, you don't need reset-names.

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151123/fc2cf61a/attachment.sig>
