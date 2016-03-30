From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 30 Mar 2016 16:19:04 +0200
Subject: [PATCH v3 08/18] dt-bindings: Add PLX Technology Reset
 Controller bindings
In-Reply-To: <1458838215-23314-9-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
 <1458838215-23314-9-git-send-email-narmstrong@baylibre.com>
Message-ID: <1459347544.2505.63.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 24.03.2016, 17:50 +0100 schrieb Neil Armstrong:
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/reset/plxtech,reset.txt    | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/plxtech,reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/plxtech,reset.txt b/Documentation/devicetree/bindings/reset/plxtech,reset.txt
> new file mode 100644
> index 0000000..581c974
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/plxtech,reset.txt
> @@ -0,0 +1,58 @@
> +PLX Technology OXNAS SoC Family RESET Controller
> +================================================
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible: Should be "oxsemi,ox810se-reset"
> +- #reset-cells: 1, see below
> +
> +Parent node should have the following properties :
> +- compatible: Should be "oxsemi,ox810se-sys-ctrl", "syscon", "simple-mfd"

So oxsemi developed oxnas, got bought up by plxtech, which was bought by
avago, which then acquired broadcom and adopted its name?

If there's agreement bout the oxsemi vendor prefix, I'd rename
plxtech,reset.txt to oxsemi,reset.txt and replace all occurrences of PLX
Technology with Oxford Semiconductor.

With this cleared up, I'll be happy to take this and patch 7.

best regards
Philipp
