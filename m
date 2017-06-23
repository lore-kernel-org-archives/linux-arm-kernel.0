From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Jun 2017 13:51:07 -0500
Subject: [PATCH 2/3] dt-bindings: arm: amlogic: Add Libre Computer Board
In-Reply-To: <20170616120648.23320-3-jbrunet@baylibre.com>
References: <20170616120648.23320-1-jbrunet@baylibre.com>
 <20170616120648.23320-3-jbrunet@baylibre.com>
Message-ID: <20170623185107.yw7arhouu4byqbpk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 02:06:47PM +0200, Jerome Brunet wrote:
> Add bindings documentation for the Libre Computer Board from Imprecision
> Systems
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
> index 5c01e65951fa..d1c77d7ae11d 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
> @@ -51,6 +51,7 @@ Board compatible values (alphabetically, grouped by SoC):
>  
>    - "amlogic,p212" (Meson gxl s905x)
>    - "hwacom,amazetv" (Meson gxl s905x)
> +  - "imprecision,librecomputer" (Meson gxl s905x)

Perhaps libre-computer?

Either way,

Acked-by: Rob Herring <robh@kernel.org>
