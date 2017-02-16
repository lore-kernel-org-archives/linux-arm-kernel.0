From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Feb 2017 20:34:08 -0600
Subject: [PATCH v2 4/9] dt-bindings: Add Ampire AM-480272H3TMQW-T01H panel
In-Reply-To: <1486738489-22154-5-git-send-email-yannick.fertre@st.com>
References: <1486738489-22154-1-git-send-email-yannick.fertre@st.com>
 <1486738489-22154-5-git-send-email-yannick.fertre@st.com>
Message-ID: <20170216023408.apqukipi5zzkrk7j@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 03:54:44PM +0100, Yannick Fertre wrote:
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

No GPIO controls or power supply for this panel?

Rob
