From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Mar 2018 17:24:30 -0500
Subject: [PATCH 2/7] drm/panel: add panel CDTech S070_WV95_CT16 to
 panel-simple
In-Reply-To: <1521662593-25468-2-git-send-email-giulio.benetti@micronovasrl.com>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-2-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180326222430.jysohrvgcmlsdclj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 09:03:08PM +0100, Giulio Benetti wrote:
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../display/panel/cdtech,s070wv95-ct16.txt         |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt b/Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt
> new file mode 100644
> index 0000000..b00d6c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/cdtech,s070wv95-ct16.txt
> @@ -0,0 +1,7 @@
> +CDTech(H.K.) Electronics Limited 7" 800x480 color TFT-LCD panel
> +
> +Required properties:
> +- compatible: should be "cdtech,s070wv95-ct16"
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

Please be specific as to what properties apply. In particular, are you 
not describing the power supply and it has multiple supplies or the 
panel has a single supply?

Rob
