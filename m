From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Mar 2018 17:24:35 -0500
Subject: [PATCH 3/7] drm/panel: add panel CDTech S043WQ26H-CT7 to
 panel-simple
In-Reply-To: <1521662593-25468-3-git-send-email-giulio.benetti@micronovasrl.com>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-3-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180326222435.uip56y2w6wetycam@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 09:03:09PM +0100, Giulio Benetti wrote:
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../display/panel/cdtech,s043wq26h-ct7.txt         |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 28 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt b/Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt
> new file mode 100644
> index 0000000..a22af85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt
> @@ -0,0 +1,7 @@
> +CDTech(H.K.) Electronics Limited 4.3" 480x272 color TFT-LCD panel
> +
> +Required properties:
> +- compatible: should be "cdtech,s043wq26h-ct7"
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

Same comment here.

Also, please split bindings to separate patches.

Rob
