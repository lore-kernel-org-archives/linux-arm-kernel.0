From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 13:39:16 -0600
Subject: [PATCH v3 3/7] dt-bindings: Add Ampire AM-480272H3TMQW-T01H panel
In-Reply-To: <1487606921-26981-4-git-send-email-yannick.fertre@st.com>
References: <1487606921-26981-1-git-send-email-yannick.fertre@st.com>
 <1487606921-26981-4-git-send-email-yannick.fertre@st.com>
Message-ID: <20170227193916.5k7ti7e3xumzq7v3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 05:08:37PM +0100, Yannick Fertre wrote:
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---
>  .../bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt         | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
> new file mode 100644
> index 0000000..f59e3c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
> @@ -0,0 +1,7 @@
> +Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "ampire,am-480272h3tmqw-t01h"

No GPIO controls nor power supplies? You need to be explicit if using 
'power-supply' or not?

> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.
> -- 
> 1.9.1
> 
