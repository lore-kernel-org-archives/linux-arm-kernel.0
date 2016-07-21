From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu, 21 Jul 2016 10:34:40 +0930
Subject: [PATCH 07/12] syscon: dt-bindings: Add documentation for Aspeed
 system control units
In-Reply-To: <20160720190901.GA11147@rob-hp-laptop>
References: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
 <1468994313-13538-8-git-send-email-andrew@aj.id.au>
 <20160720190901.GA11147@rob-hp-laptop>
Message-ID: <1469063080.954.109.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-07-20 at 14:09 -0500, Rob Herring wrote:
> On Wed, Jul 20, 2016 at 03:28:28PM +0930, Andrew Jeffery wrote:
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > ?Documentation/devicetree/bindings/mfd/aspeed-scu.txt | 16 ++++++++++++++++
> > ?1 file changed, 16 insertions(+)
> > ?create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-scu.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/aspeed-scu.txt b/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
> > new file mode 100644
> > index 000000000000..4df798799101
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
> > @@ -0,0 +1,16 @@
> > +The Aspeed System Control Unit manages the global behaviour of the SoC,
> > +configuring elements such as clocks, pinmux, and reset.
> > +
> > +Required properties:
> > +- compatible:	One of:
> > +		"aspeed,g4-scu", "syscon", "simple-mfd"
> > +		"aspeed,g5-scu", "syscon", "simple-mfd"
> These (and the pinctrl probably) really need SoC specific compatible?
> strings. You can keep these as fallbacks though. These are the parts of?
> SoCs that really vary chip to chip.

I'll add the SoC-specific compatible strings.

Cheers,

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160721/23cf50ff/attachment-0001.sig>
