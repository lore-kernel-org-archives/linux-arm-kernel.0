From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Nov 2018 16:09:09 -0600
Subject: [PATCH v2 4/7] dt-bindings: Add bindings for the LeMaker
 BL035-RGB-002 LCD panel
In-Reply-To: <20181101200045.6078-5-contact@paulk.fr>
References: <20181101200045.6078-1-contact@paulk.fr>
 <20181101200045.6078-5-contact@paulk.fr>
Message-ID: <20181105220909.GA24283@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2018 at 09:00:42PM +0100, Paul Kocialkowski wrote:
> This adds the device-tree bindings for the LeMaker BL035-RGB-002 3.5"
> QVGA TFT LCD panel, compatible with simple-panel.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  .../bindings/display/panel/lemaker,bl035-rgb-002.txt       | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt b/Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt
> new file mode 100644
> index 000000000000..22cff3eb1b8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt
> @@ -0,0 +1,7 @@
> +LeMaker BL035-RGB-002 3.5" QVGA TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "lemaker,bl035-rgb-002"

No power supply or backlight? You need to enumerate exactly which 
properties you are using.

> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.
> -- 
> 2.19.1
> 
