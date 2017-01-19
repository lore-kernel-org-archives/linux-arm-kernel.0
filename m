From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Jan 2017 10:32:48 -0600
Subject: [PATCH v1 3/7] dt-bindings: Add Ampire AM-480272H3TMQW-T01H panel
In-Reply-To: <1484573344-11609-4-git-send-email-yannick.fertre@st.com>
References: <1484573344-11609-1-git-send-email-yannick.fertre@st.com>
 <1484573344-11609-4-git-send-email-yannick.fertre@st.com>
Message-ID: <20170119163248.botftlakcae65ehz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 02:29:00PM +0100, Yannick Fertre wrote:
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

No GPIOs or power supply?

> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.
> -- 
> 1.9.1
> 
