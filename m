From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 13 Dec 2016 15:23:13 +1030
Subject: [PATCH v3 6/6] mfd: dt: Move syscon bindings to syscon
 subdirectory
In-Reply-To: <20161212153911.drhczoagyyhu7jm4@rob-hp-laptop>
References: <20161206025321.1792-1-andrew@aj.id.au>
 <20161206025321.1792-7-andrew@aj.id.au>
 <20161212153911.drhczoagyyhu7jm4@rob-hp-laptop>
Message-ID: <1481604793.3112.32.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-12-12 at 09:39 -0600, Rob Herring wrote:
> On Tue, Dec 06, 2016 at 01:53:21PM +1100, Andrew Jeffery wrote:
> > The use of syscons is growing, lets collate them in their own part of
> > the bindings tree.
> > 
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > ?Documentation/devicetree/bindings/mfd/{ => syscon}/aspeed-scu.txt?????????| 0
> > ?Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-gpbr.txt?????????| 0
> > ?Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-matrix.txt???????| 0
> > ?Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-smc.txt??????????| 0
> > ?Documentation/devicetree/bindings/mfd/{ => syscon}/qcom,tcsr.txt??????????| 0
> > ?Documentation/devicetree/bindings/mfd/{ => syscon}/syscon.txt?????????????| 0
> > ?.../devicetree/bindings/mfd/{ => syscon}/ti-keystone-devctrl.txt??????????| 0
> > ?7 files changed, 0 insertions(+), 0 deletions(-)
> > ?rename Documentation/devicetree/bindings/mfd/{ => syscon}/aspeed-scu.txt (100%)
> > ?rename Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-gpbr.txt (100%)
> > ?rename Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-matrix.txt (100%)
> > ?rename Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-smc.txt (100%)
> > ?rename Documentation/devicetree/bindings/mfd/{ => syscon}/qcom,tcsr.txt (100%)
> > ?rename Documentation/devicetree/bindings/mfd/{ => syscon}/syscon.txt (100%)
> > ?rename Documentation/devicetree/bindings/mfd/{ => syscon}/ti-keystone-devctrl.txt (100%)
> 
> I'm not so sure this is the right direction. syscon usage is pretty much?
> spread throughout the tree.

This patch was created based on my interpretation of Lee's feedback
here:

https://lkml.org/lkml/2016/11/18/650

Lee's next email in the chain poked Arnd for an opinion, but Arnd
didn't reply.

I don't mind. I moved these bindings separately so we could just drop
the patch if there was push-back. If we drop the whole idea I'll need
to apply a small fix to patch 5/6 to avoid creating the syscon
subdirectory.

Andrew

> 
> Rob
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161213/6325a813/attachment-0001.sig>
