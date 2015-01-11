From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 11 Jan 2015 13:29:44 +0200
Subject: [PATCH v2 4/8] irqchip: devicetree: document Conexant Digicolor
 irq binding
In-Reply-To: <54AFEFEC.5000300@cogentembedded.com>
References: <cover.1420744368.git.baruch@tkos.co.il>
 <3bdf8fa0bf971b4881024e72312c3c9d29298e79.1420744369.git.baruch@tkos.co.il>
 <54AFEFEC.5000300@cogentembedded.com>
Message-ID: <20150111112944.GP2481@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Jan 09, 2015 at 06:12:44PM +0300, Sergei Shtylyov wrote:
> On 1/8/2015 10:40 PM, Baruch Siach wrote:
> 
> >Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >---
> >  .../bindings/interrupt-controller/digicolor-ic.txt   | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt
> 
> >diff --git a/Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt
> >new file mode 100644
> >index 000000000000..fdf9a4c59bf3
> >--- /dev/null
> >+++ b/Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt
> >@@ -0,0 +1,20 @@
> >+Conexant Digicolor Interrupt Controller
> >+
> >+Required properties:
> >+
> >+- compatible : should be "cnxt,cx92755-ic"
> >+- reg : Specifies base physical address and size of the MISC area, that is
> >+  where the interrupt controller registers are located
> >+- interrupt-controller : Identifies the node as an interrupt controller
> >+- #interrupt-cells : Specifies the number of cells needed to encode an
> >+  interrupt source. The value shall be 1.
> >+
> >+Example:
> >+
> >+	intc: intc at f0000000 {
> 
>    The node name should be "interrupt-controller at f0000000", according to the
> ePAPR standard, section 2.2.2.

I'll change that in my next submission.

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
