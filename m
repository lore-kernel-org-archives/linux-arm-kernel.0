From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 24 Jul 2015 07:50:27 -0700
Subject: [RFC 1/3] docs: dts: Added documentation for Xilinx Zynq PL
 Reset bindings.
In-Reply-To: <55B1C1CB.2050402@xilinx.com>
References: <1437691862-21312-1-git-send-email-moritz.fischer@ettus.com>
 <1437691862-21312-2-git-send-email-moritz.fischer@ettus.com>
 <55B1C1CB.2050402@xilinx.com>
Message-ID: <20150724145027.GY2531@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-07-24 at 06:40AM +0200, Michal Simek wrote:
> On 07/24/2015 12:51 AM, Moritz Fischer wrote:
> > Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> > ---
> >  Documentation/devicetree/bindings/reset/zynq-reset-pl.txt | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
> > new file mode 100644
> > index 0000000..ac4499e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
> > @@ -0,0 +1,13 @@
> > +Xilinx Zynq PL Reset Manager
> 
> I think there is no reason to be just PL specific.

That was my first thought too. Why not model all the resets in the SLCR?

	S?ren
