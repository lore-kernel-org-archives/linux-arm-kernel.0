From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Feb 2017 11:48:16 -0600
Subject: [PATCH v3 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <b098c4fa9fce88361cca20417978734d0e1b5cca.1485939041.git-series.maxime.ripard@free-electrons.com>
References: <b098c4fa9fce88361cca20417978734d0e1b5cca.1485939041.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170201174816.oozcuq7b2y5d6fss@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 09:53:22AM +0100, Maxime Ripard wrote:
> The ARM Mali Utgard GPU family is embedded into a number of SoCs from
> Allwinner, Amlogic, Mediatek or Rockchip.
> 
> Add a binding for the GPU of that family.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> ---
> Changes from v2:
>   - Drop 0 in the unit-address
>   - Add missing st compatible
>   - Add Amlogic compatibles
> 
> Changes from v1:
>   - Dropped the arm,mali-utgard compatible
>   - Made the clocks mandatory
>   - Added Linus Walleij Reviewed-by, and the ST compatible for the Mali
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 82 ++++++++-
>  1 file changed, 82 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt

Acked-by: Rob Herring <robh@kernel.org>
