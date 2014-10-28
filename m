From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 28 Oct 2014 09:53:19 +0100
Subject: [PATCH 7/8] mfd/regulator: dt-bindings: max77686: Document gpio
 property
In-Reply-To: <544EA7D4.8070406@collabora.co.uk>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
 <1414422226-10948-8-git-send-email-k.kozlowski@samsung.com>
 <544EA7D4.8070406@collabora.co.uk>
Message-ID: <1414486399.24949.20.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




On pon, 2014-10-27 at 21:15 +0100, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 10/27/2014 04:03 PM, Krzysztof Kozlowski wrote:
> > Document usage of gpio property which turns on external control over
> > regulator.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/max77686.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/max77686.txt b/Documentation/devicetree/bindings/mfd/max77686.txt
> > index 75fdfaf41831..e41dfa7e2b90 100644
> > --- a/Documentation/devicetree/bindings/mfd/max77686.txt
> > +++ b/Documentation/devicetree/bindings/mfd/max77686.txt
> > @@ -39,6 +39,9 @@ to get matched with their hardware counterparts as follow:
> >  	-BUCKn	:	1-4.
> >    Use standard regulator bindings for it ('regulator-off-in-suspend').
> >  
> > +  Optional properties:
> > +  - gpio : GPIO to use for external control. Valid only for LDO20, LDO21,
> > +    LDO22, BUCK8 and BUCK9 regulators.
> 
> When using the descriptor-based GPIO interface the standard is to use as the DT
> property name a prefix documenting the GPIO function + a -gpios or -gpio suffix.
> So this should be something like ec-gpio.

OK.

Best regards,
Krzysztof

> 
> Best regards,
> Javier
