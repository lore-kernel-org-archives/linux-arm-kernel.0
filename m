From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Feb 2017 11:52:06 +0100
Subject: [PATCH v3 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <20170201174816.oozcuq7b2y5d6fss@rob-hp-laptop>
References: <b098c4fa9fce88361cca20417978734d0e1b5cca.1485939041.git-series.maxime.ripard@free-electrons.com>
 <20170201174816.oozcuq7b2y5d6fss@rob-hp-laptop>
Message-ID: <20170202105206.d27tqosreklivp2x@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 11:48:16AM -0600, Rob Herring wrote:
> On Wed, Feb 01, 2017 at 09:53:22AM +0100, Maxime Ripard wrote:
> > The ARM Mali Utgard GPU family is embedded into a number of SoCs from
> > Allwinner, Amlogic, Mediatek or Rockchip.
> > 
> > Add a binding for the GPU of that family.
> > 
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > 
> > ---
> > Changes from v2:
> >   - Drop 0 in the unit-address
> >   - Add missing st compatible
> >   - Add Amlogic compatibles
> > 
> > Changes from v1:
> >   - Dropped the arm,mali-utgard compatible
> >   - Made the clocks mandatory
> >   - Added Linus Walleij Reviewed-by, and the ST compatible for the Mali
> > ---
> >  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 82 ++++++++-
> >  1 file changed, 82 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied both, with the acked-by. Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170202/db070099/attachment.sig>
