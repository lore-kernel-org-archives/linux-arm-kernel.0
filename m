From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 16 Jul 2014 10:03:21 +0100
Subject: [PATCH 1/6] dt-bindings: arm: add arm,cortex-a12 cpu compatible
 property
In-Reply-To: <20140716005616.GB26207@quad.lixom.net>
References: <1471578.ILeMmG2DL6@diego> <2686681.eHDb2kq8iP@diego>
 <20140716005616.GB26207@quad.lixom.net>
Message-ID: <20140716090321.GB26951@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 01:56:16AM +0100, Olof Johansson wrote:
> On Wed, Jul 16, 2014 at 12:59:33AM +0200, Heiko St?bner wrote:
> > This is necessary for the new RK3288 soc.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> > index 1fe72a0..620a1a8 100644
> > --- a/Documentation/devicetree/bindings/arm/cpus.txt
> > +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> > @@ -152,6 +152,7 @@ nodes to be present and contain the properties described below.
> >  			    "arm,cortex-a7"
> >  			    "arm,cortex-a8"
> >  			    "arm,cortex-a9"
> > +			    "arm,cortex-a12"
> >  			    "arm,cortex-a15"
> >  			    "arm,cortex-a53"
> 
> You might as well add -a17 while you're at it, since it's an announced part
> from ARM.

Yes please!

For said patch with both strings:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
