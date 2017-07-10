From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Jul 2017 13:55:19 +0200
Subject: [linux-sunxi] [PATCH v5 5/6] ARM: sun7i: Convert to CCU
In-Reply-To: <4091e67f-6207-26ef-85f1-e9ff509dd3b7@schinagl.nl>
References: <cover.23e9103a2becf2261d7e145bb1516221a5cfb8a4.1499197129.git-series.plaes@plaes.org>
 <2ff8930c51b90a0bb875ecc6c4737f44b3314e7f.1499197129.git-series.plaes@plaes.org>
 <4091e67f-6207-26ef-85f1-e9ff509dd3b7@schinagl.nl>
Message-ID: <20170710115519.sddpeyvbxq5llunf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 10, 2017 at 01:23:51PM +0200, Olliver Schinagl wrote:
> Hi Pleas,
> 
> On 04-07-17 22:05, Priit Laes wrote:
> > Convert sun7i-a20.dtsi to new CCU driver.
> > 
> > Tested on Cubietruck.
> > 
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> > ---
> >  arch/arm/boot/dts/sun7i-a20.dtsi | 719 +++-----------------------------
> >  1 file changed, 84 insertions(+), 635 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> > index 96bee77..a5ca5a8 100644
> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> > @@ -46,8 +46,6 @@
> > 
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/thermal/thermal.h>
> > -
> > -#include <dt-bindings/clock/sun4i-a10-pll2.h>
> >  #include <dt-bindings/dma/sun4i-a10.h>
> I had to add these includes here to make this all work:

That's unlikely, none of the defines are used in this patch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170710/f4836d19/attachment.sig>
