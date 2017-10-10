From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Oct 2017 09:45:46 -0700
Subject: [PATCH 1/7] dt-bindings: bus: Minimal TI sysc interconnect
 target module binding
In-Reply-To: <20171010154614.gby64lglieag2lpn@rob-hp-laptop>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-2-tony@atomide.com>
 <20171010154614.gby64lglieag2lpn@rob-hp-laptop>
Message-ID: <20171010164545.GV4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [171010 08:47]:
> On Fri, Sep 29, 2017 at 03:34:05PM -0700, Tony Lindgren wrote:
> >  Documentation/devicetree/bindings/bus/ti-sysc.txt | 93 +++++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/bus/ti-sysc.txt
> 
> One typo below, otherwise:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> > diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
> > new file mode 100644
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
> > @@ -0,0 +1,93 @@
> > +Texas Instruments sysc interconnect target module wrapper binding
> > +
> > +Texas Instruments SoCs can have a generic interconnect target module
> > +hardware for devices connected to various interconnects such as L3
> > +interconnect (Arteris NoC) and L4 interconnect (Sonics s3220). The sysc
> > +is mostly used for interaction between module and PRCM. It participates
> > +in the OCP Disconnect Protocol but other than that is mostly indepenent
> 
> s/indepenent/independent/
> 
> > +of the interconnect.

OK thanks for looking, will fix before applying.

Regards,

Tony
