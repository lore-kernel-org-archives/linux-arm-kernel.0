From: robh@kernel.org (Rob Herring)
Date: Wed, 3 Jan 2018 15:29:55 -0600
Subject: [PATCH 1/5] drm/panel: simple: add support for Ampire
 AM-800480AYTZQW-00H
In-Reply-To: <1514883738-16297-1-git-send-email-jagan@amarulasolutions.com>
References: <1514883738-16297-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20180103211257.ybddbf6cbdudkv5y@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 02:32:14PM +0530, Jagan Teki wrote:
> This adds support for the Ampire AM-800480AYTZQW-00H 7.0" WGA LCD,
> which can be supported by the simple panel driver.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../display/panel/ampire,am-800480aytzqw-00h.txt   |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt b/Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt
> new file mode 100644
> index 0000000..bfa7a70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt
> @@ -0,0 +1,7 @@
> +Ampire AM-800480AYTZQW-00H 7.0" WVGA TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "ampire,am-800480aytzqw-00h"
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

You need to be explicit as to which properties from it you are using.

Rob
