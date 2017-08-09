From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Aug 2017 09:59:29 +0200
Subject: [PATCH  1/2] dt-bindings: i2c: Document r8a7743/5 support
In-Reply-To: <20170808115006.GC1674@katana>
References: <1502191231-8682-1-git-send-email-biju.das@bp.renesas.com>
 <20170808115006.GC1674@katana>
Message-ID: <20170809075929.GG2705@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 01:50:06PM +0200, Wolfram Sang wrote:
> On Tue, Aug 08, 2017 at 12:20:31PM +0100, Biju Das wrote:
> > Document i2c Device Tree support for RZ/G1[ME]
> > (also known as r8aA774[35]) SoCs. They are compatible with
> > R-Car Gen2 SoC family.
> > 
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> 
> Looks good to me, yet I'd like an ack from Simon who is currently
> working on the generic fallback compatibles.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> 
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> > index 2b8bd33..cad39ae 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> > @@ -2,6 +2,8 @@ I2C for R-Car platforms
> >  
> >  Required properties:
> >  - compatible:
> > +	"renesas,i2c-r8a7743" if the device is a part of a R8A7743 SoC.
> > +	"renesas,i2c-r8a7745" if the device is a part of a R8A7745 SoC.
> >  	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
> >  	"renesas,i2c-r8a7779" if the device is a part of a R8A7779 SoC.
> >  	"renesas,i2c-r8a7790" if the device is a part of a R8A7790 SoC.
> > @@ -12,7 +14,8 @@ Required properties:
> >  	"renesas,i2c-r8a7795" if the device is a part of a R8A7795 SoC.
> >  	"renesas,i2c-r8a7796" if the device is a part of a R8A7796 SoC.
> >  	"renesas,rcar-gen1-i2c" for a generic R-Car Gen1 compatible device.
> > -	"renesas,rcar-gen2-i2c" for a generic R-Car Gen2 compatible device.
> > +	"renesas,rcar-gen2-i2c" for a generic R-Car Gen2 or RZ/G1 compatible
> > +				device.
> >  	"renesas,rcar-gen3-i2c" for a generic R-Car Gen3 compatible device.
> >  	"renesas,i2c-rcar" (deprecated)
> >  
> > -- 
> > 1.9.1
> > 
