From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 13 Aug 2018 14:53:10 +0530
Subject: [PATCH v2 1/3] dt-bindings: interrupt-controller: Actions
 external interrupt controller
In-Reply-To: <20180813091547.GA22149@mani>
References: <20180812122215.1079590-1-pn@denx.de>
 <20180812122215.1079590-2-pn@denx.de>
 <20180813043406.GA16275@Mani-XPS-13-9360>
 <f1043a48-6c8d-cf08-d6a1-582d84ea2530@arm.com>
 <20180813091547.GA22149@mani>
Message-ID: <20180813092310.GA27215@mani>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2018 at 02:45:47PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Aug 13, 2018 at 08:51:54AM +0100, Marc Zyngier wrote:
> > On 13/08/18 05:34, Manivannan Sadhasivam wrote:
> > > Hi Parthiban,
> > > 
> > > On Sun, Aug 12, 2018 at 02:22:13PM +0200, Parthiban Nallathambi wrote:
> > >> Actions Semi OWL family SoC's provides support for external interrupt
> > >> controller to be connected and controlled using SIRQ pins. S500, S700
> > >> and S900 provides 3 SIRQ lines and works independently for 3 external
> > >> interrupt controllers.
> > >>
> > >> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> > >> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > >> ---
> > >>  .../interrupt-controller/actions,owl-sirq.txt      | 46 ++++++++++++++++++++++
> > >>  1 file changed, 46 insertions(+)
> > >>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> > >> new file mode 100644
> > >> index 000000000000..4b8437751331
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> > >> @@ -0,0 +1,46 @@
> > >> +Actions Semi Owl SoCs SIRQ interrupt controller
> > >> +
> > >> +S500, S700 and S900 SoC's from Actions provides 3 SPI's from GIC,
> > >> +in which external interrupt controller can be connected. 3 SPI's
> > >> +45, 46, 47 from GIC are directly exposed as SIRQ. It has
> > >> +the following properties:
> > > 
> > > We should really document the driver here. What it does? and how the
> > > hierarchy is handled with GIC? etc...
> > 
> > Absolutely not. This should document the binding, irrespective of the
> > operating system. The word "driver" is completely out of place here.
> >
> 
> Oops, my bad. I meant to say that we should add it as a description in the
> commit message.
>

...commit message of the driver patch (to be more explicit)
 
> Thanks,
> Mani
> 
> > Thanks,
> > 
> > 	M.
> > -- 
> > Jazz is not dead. It just smells funny...
